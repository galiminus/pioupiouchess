class AddTweetIdToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :tweet_reference, :string, index: true
  end
end
