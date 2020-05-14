class OrderItem < ApplicationRecord

	belongs_to :item
	belongs_to :order

    validates　:item_id, presence: true
    validates　:order_id, presence: true
	validates　:amount, presence: true
	validates　:making_status, presence: true
	validates　:order_price, presence: true
end
