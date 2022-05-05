class Admin::AdminUsersController < Admin::ApplicationController
  def sign_in
    return if request.get?
    admin_user = AdminUser.find_by_user_name_and_password(
      sign_in_params[:user_name],
      sign_in_params[:password]
    )
    unless admin_user
      flash[:alert] = "ユーザ名もしくはパスワードが異なります"
      redirect_to sign_in_admin_admin_users_path
      return
    end
    sign_in_admin_user(admin_user)
    redirect_to admin_path
  end

  def sign_out
    sign_out_admin_user
    flash[:notice] = "サインアウトしました"
    redirect_to sign_in_admin_admin_users_path
  end

  private

  def sign_in_params
    params.require(:admin_user).permit(:user_name, :password)
  end
end
