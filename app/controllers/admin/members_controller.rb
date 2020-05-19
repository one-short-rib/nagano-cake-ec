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
#		if 
		@member.update(member_params)
		redirect_to admin_members_path#向かうページ
#		else
#			render エラー作るならそのページ
#		end
	end
	private
	def member_params
		params.require(:member).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :postal_code, :address, :is_deleted)
	end
end
