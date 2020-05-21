# frozen_string_literal: true
Kaminari.configure do |config|
	#admin-indexページをページングする際に記述、他箇所に影響あれば再検討
	config.default_per_page = 10
end
