class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
   		:last_name_kana, :first_name_kana, :email, :phone_number, :postal_code, :address ])
  end

  def check_member
  	current_member.is_deleted == true
    flash[:danger] = "退会済みアカウントです。ご利用するには新たに会員登録するか管理者にご連絡ください"
  	redirect_to root_path
  end
end