class Api::StatsController < ApplicationController
  def index
    params[:period] == 'weekly' ? render_weekly : render_monthly
  end

  private

  attr_reader :rides

  def render_monthly
    stats = StatSerializer.new(Ride.monthly).serialize_monthly
    render json: stats, status: :ok
  end

  def render_weekly
    render json: StatSerializer.new(Ride.weekly).serialize_weekly, status: :ok
  end
end