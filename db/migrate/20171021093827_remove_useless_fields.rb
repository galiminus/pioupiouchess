class RemoveUselessFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :turn_count
    remove_column :games, :fen
    remove_column :games, :status
  end
end
