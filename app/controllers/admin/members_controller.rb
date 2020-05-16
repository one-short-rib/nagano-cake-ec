class Admin::MembersController < ApplicationController
	def index
		@members = Member.all
	end
	def show
	end
	def edit
	end
	def update
	end
end
