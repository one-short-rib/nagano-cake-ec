module Admin::OrdersHelper

	def sub_total(order_item) 
		order_item.order_price*order_item.amount
	end

	def total
		order_items = OrderItem.all
		total = 0
		order_items.each do |order_item|
			total += order_item.order_price
		end
		return total
	end

	def total_billed_amount
		total + @order.postage
	end
end
