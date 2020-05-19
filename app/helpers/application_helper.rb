module ApplicationHelper

	def full_name(member)
		member.last_name+member.first_name
	end
end
