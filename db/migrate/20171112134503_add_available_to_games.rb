class AddAvailableToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :available, :integer
  end
end
