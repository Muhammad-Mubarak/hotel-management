class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.string :name
      t.text :description
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
