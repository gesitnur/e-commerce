class Product < ApplicationRecord
         
    has_many :carts
    has_many :order_items
    has_one :inventory
    belongs_to :category
    belongs_to :user

    # accepts_nested_attributes_for :inventory  

    mount_uploader :image, ImageUploader

    def add_stock val, qty
        stock = val.inventory.stock

        val.inventory.update(stock: stock - qty )

    end

    def self.restore_stock val
        coba = []
        no = 0;
        val
        val.each do |p|
            product = Product::find(p.product_id)
            
            stock = product.inventory.stock

            product.inventory.update(stock: stock + p.qty )
            

            no += 1
        end

    end
    
end
