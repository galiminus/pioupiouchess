class GamesController < ApplicationController
  before_action :ensure_signed_in
  before_action :load_parent, only: [:new, :resign]
  before_action :set_game, only: [:resign, :create]

  def new
    redirect_to root_path if @parent.blank?
  end

  def create
    @game.assign_attributes(params.require(:game).permit(:move, :parent_id))
    @game.save!

    post_to_twitter_and_redirect
  end

  def resign
    @game.assign_attributes(pgn: @parent.pgn)

    @game.chess_game.resign(@game.chess_game.active_player)
    @game.refresh_pgn
    @game.save!

    post_to_twitter_and_redirect
  end

  protected

  def set_game
    @game = Game.new
    @game.user = @current_user
    @game.parent = @parent
  end

  def load_parent
    @parent =
      if params[:parent_id] || params[:game_id]
        Game.find_by(id: (params[:parent_id] || params[:game_id]))
      else
        Game.find_by(parent_id: nil)
      end
  end

  def post_to_twitter_and_redirect
    unless ENV["NO_TWITTER"] == "true"
      @game.update!(tweet_reference: TwitterNotifier.push(@game).id)
    end

    if @game.user.present? && @game.tweet_reference.present?
      redirect_to Pathname.new("https://twitter.com").join(@game.user.nickname, "status", @game.tweet_reference).to_s
    else
      redirect_to new_game_path(parent_id: @game.id)
    end
  end

  def ensure_signed_in
    if @current_user.blank?
      redirect_to "/auth/twitter?parent_id=#{params[:parent_id]}"
    end
  end
end
