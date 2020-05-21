module ApplicationHelper

	def full_name(member)
		member.last_name+member.first_name
	end

	def full_name_kana(member)
		member.last_name_kana+member.first_name_kana
	end

	def tax_include(price)
		(price*1.1).floor
	end

	def subtotal_price(item)
		tax_include(item.item.price)*item.amount
	end

	def cart_total_price(cart_items)
		total_price = 0
		cart_items.each do |cart_item|
			total_price += subtotal_price(cart_item)
		end
		return total_price
	end

end
