class ResetAllProductCacheCounters < ActiveRecord::Migration[7.0]
  def up

    Product.all.each do |product|
   
        Product.reset_counters(product.id, :order_items)
   
        end
   
     end
   
     def down
   
        # no rollback needed
   
     end
end
