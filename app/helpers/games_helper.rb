module GamesHelper
  def game_piece_at(game, position)
    game.chess_game.current[position]
  end

  def game_moves_at(game, position)
    game.chess_game.current.generate_moves(position)
  end

  def game_positions
    ["8", "7", "6", "5", "4", "3", "2", "1"].map do |vposition|
      ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].map do |hposition|
        "#{hposition}#{vposition}"
      end
    end.flatten
  end

  def game_piece_image(game, position)
    case game_piece_at(game, position)
    when "P"
      "Chess_plt45.svg"
    when "R"
      "Chess_rlt45.svg"
    when "N"
      "Chess_nlt45.svg"
    when "B"
      "Chess_blt45.svg"
    when "Q"
      "Chess_qlt45.svg"
    when "K"
      "Chess_klt45.svg"
    when "p"
      "Chess_pdt45.svg"
    when "r"
      "Chess_rdt45.svg"
    when "n"
      "Chess_ndt45.svg"
    when "b"
      "Chess_bdt45.svg"
    when "q"
      "Chess_qdt45.svg"
    when "k"
      "Chess_kdt45.svg"
    else
      "empty.png"
    end
  end

  def game_status(game)
    GamesHelper.game_status(game)
  end

  def self.game_status(game)
    if game.chess_game.status == :white_won
      "Checkmate, white player wins"
    elsif game.chess_game.status == :black_won
      "Checkmate, black player wins"
    elsif game.chess_game.status == :stalemate
      "Draw, stalemate"
    elsif game.chess_game.status == :insufficient_material
      "Draw, insufficient material to checkmate"
    elsif game.chess_game.status == :fifty_rule_move
      "Draw, fifty-move rule"
    elsif game.chess_game.status == :threefold_repetition
      "Draw, threefold repetition"
    elsif game.chess_game.status == :white_won_resign
      "Black resigned"
    elsif game.chess_game.status == :black_won_resign
      "White resigned"
    elsif game.chess_game.current.check?
      "Check"
    else
      "#{(game.chess_game.moves.size + 1).ordinalize} move"
    end
  end
end
