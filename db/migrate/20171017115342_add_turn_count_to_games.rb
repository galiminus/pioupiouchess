class AddTurnCountToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :turn_count, :integer

    Game.find_each do |game|
      count = 0

      parent = game.parent
      while parent
        parent = parent.parent
        count += 1
      end

      game.update(turn_count: count)
    end
  end
end
