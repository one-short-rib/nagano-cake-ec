class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!

	def top
		now = Time.current
		@orders = Order.where(created_at: now.all_day)
	end
end
