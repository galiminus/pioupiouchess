class AddUserToGame < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :games, :user, index: true
  end
end
