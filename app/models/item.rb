class Item < ApplicationRecord

  has_many :order_items
  #中間テーブルで参照するために追加
  has_many :orders, :through => :order_items
  has_many :cart_items
  belongs_to :genre

  attachment :item_image

  validates :name, presence: true, length: { maximum: 255 }
  validates :explanation, presence: true, length: { maximum: 255 }
  validates :price, presence: true

  validates :is_saled, inclusion: [true, false]

  def self.unsale_items(genre) #特定のジャンルの商品を「売り切れ」に
      genre.items.each{|item| item.update(is_saled: false)} unless genre.is_valid
  end

  def self.saled_items(genre = "")
      genre.blank? ? Item.where(is_saled: true) : genre.items.where(is_saled: true)
  end

end
