class ChangeColumnPriceIntergerToString < ActiveRecord::Migration[7.0]
  def change
    change_column :missions, :price, :string
  end
end
