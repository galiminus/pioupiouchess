class AddPgnToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :pgn, :text

    Game.destroy_all
  end
end
