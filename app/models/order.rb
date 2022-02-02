class Order < ApplicationRecord

    has_many :order_items
    belongs_to :user
    belongs_to :other_user, :foreign_key => :vendor_id, :class_name => :other_user

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
