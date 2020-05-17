class CartItem < ApplicationRecord

	belongs_to :member
	belongs_to :item

	validates :member_id, presence: true
	validates :item_id, presence: true
	validates :amount, presence: true
end
