class AddChampsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :max_budget, :integer
    add_column :users, :single_traveler, :boolean, default: false
    add_reference :users, :category, foreign_key: true
  end
end
