class Member::MembersController < ApplicationController
	before_action :authenticate_member!
	before_action :set_member,only: [:show,:edit,:update,:is_deleted]

	def show
	end

	def edit
	end

	def update
		if @member.update(member_params)
			redirect_to members_path
		else
			render :edit
		end
	end

	def exit
	end

	def is_deleted
		@member.update(is_deleted: true)
		# flash[:danger]="退会処理が実行されました"
    redirect_to '/member/logout'
	end

	private
	def member_params
		params.require(:member).permit(:last_name,:first_name,
			:last_name_kana,:first_name_kana,
			:email,:postal_code,:address,:phone_number)
	end

	def set_member
		@member = current_member
	end

end