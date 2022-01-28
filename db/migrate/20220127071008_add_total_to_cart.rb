class AddTotalToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :total, :integer
  end
end
