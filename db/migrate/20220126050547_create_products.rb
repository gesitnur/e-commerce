class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.integer :price
      t.integer :vendor_id
      t.string :image
      t.string :weight
      t.string :condition

      t.timestamps
    end
  end
end
