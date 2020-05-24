# frozen_string_literal: true

class Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    @path = Rails.application.routes.recognize_path(request.referer)
    if @path[:controller] == "member/members"
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      flash[:danger]="退会処理が実行されました"
      yield if block_given?
      respond_to_on_destroy
    else
      super
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
