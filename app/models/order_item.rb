class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product, counter_cache: true

    # belongs_to :product, counter_cache: :order_items_count
    counter_culture :product
    # counter_culture :product, column_name: proc {|model| model.order.equal?(2) ? 'order_count' : nil }
    

end
