class Product < ApplicationRecord
         
    has_many :carts
    has_many :order_items
    has_one :inventory, :dependent => :destroy
    has_many :stock_history
    belongs_to :category
    belongs_to :vendor

    accepts_nested_attributes_for :inventory  

    mount_uploader :image, ImageUploader

    def add_stock val, qty
        stock = val.inventory.stock

        val.inventory.update(stock: stock - qty )

    end

    def self.make_log val, stock, qty, action

        if action == 'Penjualan'
            new_stock = stock - qty 
        else
            new_stock = stock + qty 
        end

        StockHistory.create(product_id: val.id, action: action, qty: qty.abs , old_stock: stock, new_stock: new_stock )

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
            
            make_log(product, p.qty, 'Reject')

            product.inventory.update(stock: stock + p.qty )

            no += 1
        end

    end

    def update_product_and_stock params
        inventory
    end
    
end
