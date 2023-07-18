class CreateUserHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :user_hotels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
