class Admin::MembersController < ApplicationController
	before_action :authenticate_admin!

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
    if @member.update(member_params)
       flash[:notice] = '更新しました。'
       redirect_to admin_members_path
    else
      render :edit
    end
  end

	private
	def member_params
		params.require(:member).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :postal_code, :address, :is_deleted)
	end
end
