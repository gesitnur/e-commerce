class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :carts
  has_many :addresses
  has_one :balance
  has_one :order
  has_one :vendor
  has_one :users_role

  accepts_nested_attributes_for :users_role

  def self.update_balance a, total
    new_total = a.balance.balance - total.to_i
    new_total

    a.balance.update(balance: new_total)

  end

  def self.restore_balance a, total
    # new_total = a.balance.balance
    new_total = a.balance.balance + total.to_i
    # total.to_i
    a.balance.update(balance: new_total)
  end

end
