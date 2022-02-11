class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product

    after_create :reduce_stock

    def reduce_stock
        product.inventory.stock -= self.qty
        product.inventory.save
        self.update(coba: 'ini percobaan')
    end 

end
