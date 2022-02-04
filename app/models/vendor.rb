class Vendor < ApplicationRecord
    belongs_to :user
    has_many :products
    has_many :carts
    has_many :orders
end
