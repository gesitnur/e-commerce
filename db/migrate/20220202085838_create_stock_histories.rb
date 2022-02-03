class CreateStockHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_histories do |t|
      t.integer :product_id
      t.string :action
      t.integer :qty
      t.integer :old_stock
      t.integer :new_stock

      t.timestamps
    end
  end
end
