class AddContinentToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :continent, :integer, default: 0
    add_column :users, :traveler_style, :integer, default: 0

    remove_column :users, :single_traveler
  end
end
