class AddUseridAndGameidToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :game_id, :integer
    add_column :games, :user_id, :integer
    add_index :games, :user_id
    add_index :games, :game_id
  end
end
