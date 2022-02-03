class Order < ApplicationRecord

    has_many :order_items
    belongs_to :user

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
