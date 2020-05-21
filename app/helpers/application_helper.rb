module ApplicationHelper

	def full_name(member)
		member.last_name+member.first_name
	end

	def full_name_kana(member)
		member.last_name_kana+member.first_name_kana
	end

	def tax_include(price)
		(price*1.1).floor
	end

	def unit_price_in_tax(pending_item) #税込単価を出す
    pending_item.class == OrderItem ? pending_item.order_price : tax_include(pending_item.item.price)
  end

	def subtotal_price(pending_item) #同商品の小計を出す
      unit_price_in_tax(pending_item)*pending_item.amount
	end

	# def subtotal_price(item)
	# 	tax_include(item.item.price)*item.amount
	# end

	def total_price(pending_items)
			total_price = 0
			pending_items.each do |pending_item|
				total_price += subtotal_price(pending_item)
			end
		return total_price
	end

end
