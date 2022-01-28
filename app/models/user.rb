class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :carts
  has_many :addresses
  has_one :balance

  def update_balance a, total
    new_total = a.balance.balance - total.to_i
    new_total

    a.balance.update(balance: new_total)

  end

end
