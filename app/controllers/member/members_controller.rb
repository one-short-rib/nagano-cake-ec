class Member::MembersController < ApplicationController

	before_action :set_member,only: [:show,:edit,:update,:is_deleted]

	def show
	end

	def edit
	end

	def update
		@member.update(member_params)
		redirect_to members_path
	end

	def exit
	end

	def is_deleted
		@member.update(is_deleted: true)
		redirect_to root_path
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