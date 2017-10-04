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

    distance = @rides.sum(:distance)
    json = distance.map do |date, ride|
      { day: date.strftime("%B, #{date.day.ordinalize}"),
        total_distance: "#{ride}km",
        avg_ride: "#{@rides.average(:distance)[date]}km",
        avg_price: "#{@rides.average(:price)[date]}PLN" } if ride > 0
    end.compact

    render json: json, status: :ok
  end

  def render_weekly
    render json: { total_distance: @rides.sum(:distance), total_price: @rides.sum(:price) }, status: :ok
  end
end