class Genre < ApplicationRecord
	has_many :items

	validates :name, presence: true, length: { maximum: 20 }
	validates :is_valid, presence: true
end
