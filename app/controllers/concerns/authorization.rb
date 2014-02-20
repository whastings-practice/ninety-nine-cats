module Authorization
  extend ActiveSupport::Concern

  def require_signed_in
    if current_user.nil?
      redirect_to cats_url
    end
  end

  def require_signed_out
    unless current_user.nil?
      redirect_to cats_url
    end
  end
end
