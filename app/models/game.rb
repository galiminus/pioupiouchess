class Game < ApplicationRecord
  BOARD_SIZE = 8

  belongs_to :parent, class_name: "Game", optional: true
  belongs_to :user, optional: true

  before_create :calculate_pgn_from_move, if: -> { parent.present? && move.present? }

  def chess_game
    @chess_game ||= Chess::Game.load_pgn({data: self.pgn})
  end

  def calculate_pgn_from_move
    parent.chess_game.move(move)

    self.pgn = parent.chess_game.pgn.to_s
  end

  def refresh_pgn
    self.pgn = chess_game.pgn.to_s
  end
end
