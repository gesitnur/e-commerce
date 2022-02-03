class AddOrderItemsCounterToProducts < ActiveRecord::Migration[7.0]
  
  def up
    add_column :products, :order_items_count, :integer, default: 0

  end

  def down
    remove_column :products, :order_items_count
  end


end    