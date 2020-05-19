module Admin::OrdersHelper

	def sub_total(order_price)
		order_price*order_item.amount
	end

	def total_price(order_items)
		order_items = OrderItem.all
		total_price = 0
		order_items.each do |order_item|
			total_price += order_item.order_price
		end
		return total_price
	end

	def total_billed_amount
		@otal_price + order.postage
		return totsl_billed_amount
	end
end
