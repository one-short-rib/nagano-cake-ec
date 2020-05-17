class OrderItem < ApplicationRecord

	belongs_to :item
	belongs_to :order

  validates :item_id, presence: true
  validates :order_id, presence: true
	validates :amount, presence: true
	validates :making_status, presence: true
	validates :order_price, presence: true

	enum making_status:[着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3]
end
