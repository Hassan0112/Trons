class CreateUserAdds < ActiveRecord::Migration[6.1]
  def change
    create_table :user_adds do |t|
      t.string :city, null:false
      t.string :registered_in
      t.string :exterior_color, null:false
      t.float :mileage, null:false
      t.integer :price, null:false
      t.string :add_description, null:false
      t.integer :mobile_number, null:false
      t.integer :secondary_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end