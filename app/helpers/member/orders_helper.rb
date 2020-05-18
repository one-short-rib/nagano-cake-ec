module Member::OrdersHelper

  def tax_include(price)
		(price*1.1).floor
	end

	def subtotal_price(pending_item)
		tax_include(pending_item.item.price)*pending_item.amount
	end

	def total_price(order)
		cart_items = order.member.cart_items
		total_price = 0
		cart_items.each {|cart_item| total_price += subtotal_price(cart_item)}
		return total_price
	end

end
