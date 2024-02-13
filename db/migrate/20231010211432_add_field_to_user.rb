class AddFieldToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :gender, :string
    add_column :users, :dob, :date
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
end