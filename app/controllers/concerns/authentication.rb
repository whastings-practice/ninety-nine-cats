module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    return nil unless cookies[:token]
    @current_user ||= Session.find_user_by_token(cookies[:token])
  end

  def sign_in_user(user)
    reset_session
    new_token = user.sessions.create!.token
    cookies[:token] = {
      value: new_token,
      httponly: true,
      expires: 1.week.from_now
    }
    @current_user = user
  end

  def sign_out_user(user)
    Session.find_by_token(cookies[:token]).try(:destroy)
    cookies.delete(:token)
  end
end
