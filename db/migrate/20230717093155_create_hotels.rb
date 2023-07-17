class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :description
      t.integer :duration
      t.decimal :price

      t.timestamps
    end
  end
end
