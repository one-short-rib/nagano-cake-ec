module Member::OrdersHelper

  def tax_include(price)
		(price*1.1).floor
	end

	def subtotal_price(pending_item)
		tax_include(pending_item.item.price)*pending_item.amount
	end

	def total_price(order)
		order_items = order.order_items
		total_price = 0
		order_items.each {|order_item| total_price += order_item.order_price*order_item.amount}
		return total_price
	end

end
