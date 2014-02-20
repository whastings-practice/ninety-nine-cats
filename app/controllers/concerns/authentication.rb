module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def sign_in_user(user)
    reset_session
    session[:token] = user.reset_session_token!
    @current_user = user
  end

  def sign_out_user(user)
    user.reset_session_token!
    session[:token] = nil
  end
end
