# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    if current_user.connections.active.count == 0
      sign_out unless RemoteConnection::ConnectionCreator.call(current_user)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    user = current_user
    super
    RemoteConnection::ConnectionDestroyer.call(user)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
