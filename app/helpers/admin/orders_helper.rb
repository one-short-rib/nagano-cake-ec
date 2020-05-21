module Admin::OrdersHelper

	def sub_total(order_item) 
		order_item.order_price*order_item.amount
	end

	#注文個数かぞえる
	def total_count(count_order)
		count = 0
		count_order.each do |item|
			count += item.amount
		end
		return count
	end
	
	#商品合計を求める
	def total(order_items)
		items = order_items
		total = 0
		items.each do |item|
			total += item.order_price*item.amount
		end
		return total
	end
	
	#いらないかも
	#def total_billed_amount
		#total = total
		#total + @order.postage
	#end
end
