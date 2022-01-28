class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total
      t.integer :status, default: 1
      t.integer :address_id

      t.timestamps
    end
  end
end
