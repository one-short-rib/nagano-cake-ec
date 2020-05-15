class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

  devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
   :last_name_kana, :first_name_kana, :phone_number, :postal_code, :address ])

end
