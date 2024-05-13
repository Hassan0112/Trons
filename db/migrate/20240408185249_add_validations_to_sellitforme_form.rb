class AddValidationsToSellitformeForm < ActiveRecord::Migration[6.1]
  def change
    change_column :sellitforme_forms, :model_year, :integer, null: false
    change_column :sellitforme_forms, :car_info, :string, null: false
    change_column :sellitforme_forms, :assembly, :string, null: false
    change_column :sellitforme_forms, :location, :string, null: false
    change_column :sellitforme_forms, :address, :string, null: false
    change_column :sellitforme_forms, :inspection_slot, :string, null: false
    change_column :sellitforme_forms, :full_name, :string, null: false
    change_column :sellitforme_forms, :phone, :string, null: false
  end
end
