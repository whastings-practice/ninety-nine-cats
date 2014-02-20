class CatRentalRequestsController < ApplicationController

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

  private

  def rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
