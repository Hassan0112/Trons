class CreateSellitformeForm < ActiveRecord::Migration[6.1]
  def change
    create_table :sellitforme_forms do |t|
      t.integer :model_year
      t.string :car_info
      t.string :registered_in
      t.string :assembly
      t.string :location
      t.string :address
      t.string :inspection_slot
      t.string :full_name
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
