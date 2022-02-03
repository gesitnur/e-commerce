class AddOrderCountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :order_count, :integer
  end
end
