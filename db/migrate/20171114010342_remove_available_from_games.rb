class RemoveAvailableFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :available, :integer
  end
end
