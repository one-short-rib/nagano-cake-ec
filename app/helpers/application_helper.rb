module ApplicationHelper

	def full_name(member)
		member.last_name+member.first_name
	end
	def full_name_kana(member)
		member.last_name_kana+member.first_name_kana
	end

end
