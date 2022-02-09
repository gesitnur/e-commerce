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

    # def self.custom_counter val
        
    #     no = 0;
    #     val
    #     val.each do |p|
    #         product = Product::find(p.product_id)
    #         counter = product.order_items_count

    #         product.update(order_items_count: counter + p.qty )
            
    #         no += 1
    #     end

        
    # end

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

    def update_product_and_stock params, action = nil

        # params
        old_stock2 = inventory.stock
        self.update(params)

        # if action == nil
            action ||= inventory.stock > old_stock2 ? 'Penambahan Stok' : 'Pengurangan Stok'
        # end
        # old_stock2
        # if inventory.stock_before_last_save
            make_log inventory.stock, old_stock2, action
        # end

    end
    
    def make_log stock, old_stock, action

        StockHistory.create(product: self, action: action, qty: (stock - old_stock).abs , old_stock: old_stock, new_stock: stock )

    end
    
end
