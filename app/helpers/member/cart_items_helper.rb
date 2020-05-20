module Member::CartItemsHelper

	def cart_total_price
		cart_items = current_member.cart_items.all
		total_price = 0
		cart_items.each do |cart_item|
			total_price += subtotal_price(cart_item)
		end
		return total_price
	end
end
