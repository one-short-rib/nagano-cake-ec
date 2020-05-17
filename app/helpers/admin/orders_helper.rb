module Admin::OrdersHelper

	def sub_total(order_item)
		order_price*order_items.amount
	end

	def total_price(order_items)
		order_items = OrderItem.all
		@total_price = 0
		order_items.each do |order_item|
			@total_price += order_item.order_price
		end
	end

	def total_billed_amount(order)
		order = Order.find(params[:id])
		@total_price += order.postage
	end
end
