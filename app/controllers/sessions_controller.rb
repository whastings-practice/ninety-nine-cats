class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:session][:user_name],
      params[:session][:password]
    )
    if user
      sign_in_user(user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["User name or password was incorrect"]
      render :new
    end
  end

  def destroy
    return unless current_user
    sign_out_user(current_user)
    redirect_to new_session_url
  end
end
