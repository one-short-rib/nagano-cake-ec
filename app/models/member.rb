class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ships, 			dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :items, 			through: :cart_items
  has_many :orders

  validates :last_name,      presence: true, length: {maximum: 10 }
  validates :first_name,     presence: true, length: {maximum: 10 }
  validates	:last_name_kana, presence: true, length: {maximum: 10 }
  validates :first_name_kana,presence: true, length: {maximum: 10 }
  validates :phone_number, 	 presence: true, length: {maximum: 12, minimum: 10 }
  validates :postal_code,    presence: true, length: {maximum: 7 }
  validates :address, 		   presence: true, length: {maximum: 255 }
  validates :email, 			   presence: true, length: {maximum: 255 }
  validates :is_deleted,     inclusion: [true, false]

  # 以下論理削除でググった結果判明したdeviseのメソッド

  # ユーザーのアカウントが有効であることの確認メソッドに条件追加
  # !is_deletedにすることでtrueの時に下の式がfalseになりアカウントが無効になる
  def active_for_authentication?
    super && !is_deleted
  end

  # 削除したユーザーにカスタムメッセージを追加
  def inactive_message
    !is_deleted ? super : "削除されたユーザーです"
  end

end
