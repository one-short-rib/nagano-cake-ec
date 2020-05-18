class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  #中間テーブルで参照したいがためにthrough追加
  has_many :items, :through => :order_items
  belongs_to :member

  validates :postal_code, presence: true, length: {is: 7}
  validates :address, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :postage, presence: true
  validates :billing_amount, presence: true

  enum order_status:{入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
  enum payment_method: {クレジットカード: 0, 銀行振込: 1}

end
