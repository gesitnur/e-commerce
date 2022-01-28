class AddVendorIdToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :vendor_id, :integer
  end
end
