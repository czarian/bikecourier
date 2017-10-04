class Api::StatsController < ApplicationController
  def index
    @rides = Ride.this_week if params[:period] == 'weekly'
    @rides = Ride.this_month.group_by_day(:date) if params[:period] == 'monthly'
    statistics

  end

  def statistics
    params[:period] == 'weekly' ? render_weekly : render_monthly
  end

  def render_monthly
    stats = StatSerializer.new(@rides).serialize_monthly
    render json: stats, status: :ok
  end

  def render_weekly
    render json: StatSerializer.new(@rides).serialize_weekly, status: :ok
  end
end