class AddStatusToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :status, :string

    Game.update_all(status: "in_progress")
  end
end
