class Order < ApplicationRecord

    has_many :order_items
    belongs_to :user
    belongs_to :vendor
    belongs_to :address

    after_update :percobaan

    def percobaan

        if self.status == 2
            # self.update_column(:coba, self.total) 
            order_items.each do |t|
                # t.product.inventory.update_column(:qty, += t.qty) 

                t.product.order_items_count += t.qty
                t.product.save
            end

            balance = vendor.user.balance
            balance.balance += self.total
            balance.save
            
        elsif self.status == 3
            # self.update_column(:coba, "Data Reject") 
            order_items.each do |t|
                # t.product.inventory.update_column(:qty, += t.qty) 

                #  t.product.inventory.stock += t.qty
                #  t.product.inventory.save

                t.product.update_product_and_stock({inventory_attributes: { stock: t.product.inventory.stock + t.qty}}, 'Reject')
            end
        end

        # self.update_column(:coba, "Data Baru") 

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
