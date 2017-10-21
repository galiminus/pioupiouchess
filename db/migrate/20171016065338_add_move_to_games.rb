class AddMoveToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :move, :string
  end
end
