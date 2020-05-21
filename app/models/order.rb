class Order < ApplicationRecord
  include ApplicationHelper

  has_many :order_items, dependent: :destroy
  #中間テーブルで参照したいがためにthrough追加
  has_many :items, :through => :order_items
  belongs_to :member

  validates :postal_code, presence: true, length: { maximum: 7 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :postage, presence: true
  validates :billing_amount, presence: true

  enum order_status:{入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
  enum payment_method: {クレジットカード: 0, 銀行振込: 1}

  def set_address(key)
      self.postal_code = key.postal_code
      self.address = key.address
      self.name = (key.class == Member)? full_name(key) : key.name
  end

  def set_new_order(choice, ship_id, postal_code, name, address)
    case choice
      when "0"
        self.set_address(self.member)
      when "1"
        self.set_address(self.member.ships.find(ship_id))
      when "2"
        ship = self.member.ships.new(postal_code: postal_code,
                                        name: name,
                                        address: address)
          self.set_address(ship)
    end
    self.billing_amount = total_price(self.member.cart_items) + self.postage
  end

  def cart_to_order(cart_items)
    cart_items.each do |cart_item|
        self.order_items.create(item: cart_item.item,
                         amount: cart_item.amount,
                         order_price: tax_include(cart_item.item.price))
    end
    cart_items.destroy_all
  end

end
