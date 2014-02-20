class UsersController < ApplicationController
  def new
    @user = User.new.decorate
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "Sign-up successful!"
      redirect_to cats_url
    else
      @user = user.decorate
      flash.now[:errors] = user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
