class CatRentalRequestsController < ApplicationController
  include Authorization
  before_action :require_signed_in
  before_action :require_owns_cat, only: [:approve, :deny]

  def new
    @rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(rental_request_params)
    if @rental_request.save
      flash[:notice] = "Your request has been submitted!"
      redirect_to cats_url
    else
      flash[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def approve
    rental_request = CatRentalRequest.find(params[:id])
    rental_request.approve!
    redirect_to cat_url(rental_request.cat)
  end

  def deny
    rental_request = CatRentalRequest.find(params[:id])
    rental_request.deny!
    redirect_to cat_url(rental_request.cat)
  end

  private

  def rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

  def require_owns_cat
    cat_id = CatRentalRequest.find(params[:id]).cat_id
    unless current_user.owns_cat?(cat_id)
      redirect_to cats_url
    end
  end

end
