class CustomAuthenticationFailure < Devise::FailureApp 
  protected

  def redirect_url 
    new_member_session_path
  end
end
