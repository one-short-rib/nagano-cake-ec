module Member::CartItemsHelper

	def tax_include(price)
		(price*1.1).floor
	end

	def subtotal_price(cart_item)
		tax_include(cart_item.item.price)*cart_item.amount
	end

	def total_price
		cart_items = current_member.cart_items.all
		total_price = 0
		cart_items.each do |cart_item|
			total_price += subtotal_price(cart_item)
		end
		return total_price
	end

end
