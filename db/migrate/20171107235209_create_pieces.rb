class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :color
      t.string :type
      t.integer :x_position
      t.integer :y_position
      t.timestamps
    end
  end
end
