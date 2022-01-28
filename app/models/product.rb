class Product < ApplicationRecord
         
    has_many :carts
    has_many :order_items
    has_one :inventory
    belongs_to :category

    mount_uploader :image, ImageUploader

    def stock val, qty
        stock = val.inventory.stock

        val.inventory.update(stock: stock - qty )

    end
    
end
