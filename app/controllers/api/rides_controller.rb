class Api::RidesController < ApplicationController
  def create
    ride = Ride.new(ride_params)
    ride.distance = DistanceReciever.new(ride_params[:address_start],
                                ride_params[:address_end]).call

    if ride.save
      render json: {}, status: :created
    else
      render json: { error: ride.errors.messages }, status: :bad_request
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:address_start, :address_end, :price, :date)
  end
end
