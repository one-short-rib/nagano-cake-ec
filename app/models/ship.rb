class Ship < ApplicationRecord

	belongs_to :user

    validates :member_id, presence: true
	validates :postal_code, presence: true
	validates :address, presence: true
	validates :name, presence: true
end
