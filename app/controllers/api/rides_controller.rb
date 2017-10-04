class Api::RidesController < ApplicationController
  def create
    render json: {}, status: :created
  end
end
