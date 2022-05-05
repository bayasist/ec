class Admin::ApplicationController < ApplicationController
  layout "admin"

  before_action :check_signed_in

  def check_signed_in
    return true if controller_name == "admin_users" && action_name == "sign_in"
    @current_admin_user = AdminUser.signed_in_user(session[:admin_user_session_id])
    redirect_to sign_in_admin_admin_users_path unless @current_admin_user
  end

  def sign_in_admin_user(admin_user)
    session_id = admin_user.sign_in
    session[:admin_user_session_id] = session_id
  end

  def sign_out_admin_user
    @current_admin_user&.sign_out
    session[:admin_user_session_id] = nil
  end
end
  