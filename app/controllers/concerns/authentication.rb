module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= Session.find_user_by_token(session[:token])
  end

  def sign_in_user(user)
    reset_session
    session[:token] = user.sessions.create!.token
    @current_user = user
  end

  def sign_out_user(user)
    Session.find_by_token(session[:token]).try(:destroy)
    session[:token] = nil
  end
end
