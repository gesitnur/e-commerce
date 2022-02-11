class Inventory < ActiveRecord::Base

    validates :stock, presence: {message: 'Stock harus Diisi'}
    
    belongs_to :product

    # validate :check_stock

    # before_save :make_history

    # def make_history

    #     action = stock > stock_was ? 'Penambahan Stok' : 'Pengurangan Stok'

    #     StockHistory.create(product: product, action: action, qty: (stock - stock_was).abs, old_stock: stock_was, new_stock: stock)

    #     update_column(:old_value, stock_was)
        
    #     update_column(:new_value, self.product.name)

    # end

    def check_stock
        errors.add(:stock, "Harus Diubah") if stock_was == stock
    end

end
