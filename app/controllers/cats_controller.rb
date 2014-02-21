class CatsController < ApplicationController
  include Authorization
  before_action :require_signed_in, only: [:new, :create, :edit, :update]
  before_action :require_owns_cat, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id]).decorate
    @rental_requests = CatRentalRequest.requests_for_cat(@cat.id)
    @owns_cat = current_user && current_user.owns_cat?(@cat)
    render :show
  end

  def new
    @cat = Cat.new.decorate
    render :new
  end

  def create
    cat = Cat.new(cat_params)
    cat.user_id = current_user.id
    if cat.save
      flash[:notice] = "Cat added successfully!"
      redirect_to cat_url(cat)
    else
      @cat = cat.decorate
      flash.now[:errors] = cat.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find(params[:id]).decorate
    render :edit
  end

  def update
    cat = Cat.find(params[:id])
    if cat.update_attributes(cat_params)
      flash[:notice] = "Cat edited successfully!"
      redirect_to cat_url(cat)
    else
      @cat = cat.decorate
      flash.now[:errors] = cat.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :sex, :color, :birth_date)
  end

  def require_owns_cat
    redirect_to cats_url unless current_user.owns_cat?(params[:id])
  end

end
