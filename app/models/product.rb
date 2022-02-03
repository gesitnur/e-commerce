class Product < ApplicationRecord
         
    has_many :carts
    has_many :order_items
    has_one :inventory
    has_many :stock_history
    belongs_to :category
    belongs_to :user

    # accepts_nested_attributes_for :inventory  

    mount_uploader :image, ImageUploader

    def add_stock val, qty
        stock = val.inventory.stock

        val.inventory.update(stock: stock - qty )

    end

    def make_log val, qty, action
        stock = val.inventory.stock

        if action == 'Penjualan'
            new_stock = stock - qty 
        else
            new_stock = stock + qty 
        end

        StockHistory.create(product_id: val.id, action: action, qty: qty, old_stock: stock, new_stock: new_stock )

    end

    def self.custom_counter val
        
        no = 0;
        val
        val.each do |p|
            product = Product::find(p.product_id)
            counter = product.order_items_count

            product.update(order_items_count: counter + p.qty )
            
            no += 1
        end

        
    end

    def create_log product_id, old_stock, qty

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
