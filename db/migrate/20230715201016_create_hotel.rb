class CreateHotel < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.float :tax
      t.time :duration

      t.timestamps
    end
  end
end
