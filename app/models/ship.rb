class Ship < ApplicationRecord

	belongs_to :user

    validates　:member_id, presence: true
	validates　:postal_code, presence: true, length:{is: 7}
	validates　:address, presence: true, length:{maximum: 255}
	validates　:name, presence: true, length:{maximum: 20}
end
