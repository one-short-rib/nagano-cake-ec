class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!
	def top
		#当日の注文総数
		now = Time.current
		@orders = Order.where(created_at: now.all_day)
	end
end
