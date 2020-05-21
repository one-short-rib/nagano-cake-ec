module Member::OrdersHelper

  # def tax_include(price) #消費税をかける
	# 	(price*1.1).floor
	# end

  

	def total_price(cart_items)
		total_price = 0
		cart_items.each {|cart_item| total_price += subtotal_price(cart_item)}
		return total_price
	end

end
