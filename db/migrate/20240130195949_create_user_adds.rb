class CreateUserAdds < ActiveRecord::Migration[6.1]
  def change
    create_table :user_adds do |t|
      t.string :city
      t.string :registered_in
      t.string :exterior_color
      t.float :mileage
      t.integer :price
      t.string :add_description
      t.integer :mobile_number
      t.integer :secondary_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
