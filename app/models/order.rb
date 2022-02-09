class Order < ApplicationRecord

    has_many :order_items
    belongs_to :user
    belongs_to :vendor
    belongs_to :address

    after_save :percobaan

    def percobaan

        if self.status == 2
            self.update_column(:coba, self.total) 
        elsif self.status == 3
            self.update_column(:coba, "Data Reject") 
        end
        # order_items.each do |t|
        #     t.update_column(:qty, 12) 
        #     t.product.update_product_and_stock({inventory_attributes: { stock: t.product.inventory.stock + t.qty}}, 'Reject')
        # end

        # t.product.update_product_and_stock({inventory_attributes: { stock: t.product.inventory.stock - t.qty}}, 'Penjualan')

    end

    def check order
        case order
        when 1
            "Pending"
        when 2
            "Diapprove Penjual  "
        when 3
            "Ditolak Penjual"
        end
    end
end
