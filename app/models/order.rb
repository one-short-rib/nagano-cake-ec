class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  has_many :items, 			through: :order_items
  belongs_to :member

  validates :postal_code, presence: true, length: {is: 7}
  validates :address, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :postage, presence: true
  validates :billing_amount, presence: true

end
