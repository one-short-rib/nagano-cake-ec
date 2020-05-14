class Item < ApplicationRecord
  has_many :order_items
  has_many :cart_items
  belongs_to :genre

  attachment :item_image

  validates :genre_id, presence :true
  validates :name, presence :true
  validates :explanation, presence :true
  validates :price, presence :true
  validates :is_saled, presence :true
  validates :item_image, presence :true
end
