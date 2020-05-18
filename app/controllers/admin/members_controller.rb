class Admin::MembersController < ApplicationController
	def index
		@members = Member.all
	end
	def show
		@member = Member.find(params[:id])
	end
	def edit
		@member = Member.find(params[:id])
	end
	def update
		@member = Member.find(params[:id])
		if @member.update(member.params)
			redirect_to #向かうページ
		else
			render #エラー作るならそのページ
		end
	end
end
