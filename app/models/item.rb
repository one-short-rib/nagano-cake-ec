class Item < ApplicationRecord
  has_many :order_items
  has_many :cart_items
  belongs_to :genre

  attachment :item_image

  validates :name, presence: true, length: { maximum: 255 }
  validates :explanation, presence: true, length: { maximum: 255 }
  validates :price, presence: true
  validates :is_saled, presence: true
  validates :item_image, presence: true
end
