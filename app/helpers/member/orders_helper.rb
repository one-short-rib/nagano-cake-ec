module Member::OrdersHelper

  def tax_include(price) #消費税をかける
		(price*1.1).floor
	end

  def unit_price_in_tax(pending_item) #税込単価を出す
    pending_item.class == OrderItem ? pending_item.order_price : tax_include(pending_item.item.price)
  end

	def subtotal_price(pending_item) #同商品の小計を出す
      unit_price_in_tax(pending_item)*pending_item.amount
	end

	def total_price(order)
		order_items = order.order_items
		total_price = 0
		order_items.each {|order_item| total_price += order_item.order_price*order_item.amount}
		return total_price
	end

  def cart_to_order
    order_items = []
    current_member.cart_items.each do |cart_item|
      order_items << OrderItem.new(item: cart_item.item,
                                   amount: cart_item.amount,
                                   order_price: tax_include(cart_item.item.price))
    end
    return order_items
  end

end
