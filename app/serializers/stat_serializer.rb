class StatSerializer
  def initialize(rides)
    @rides = rides
  end

  def serialize_weekly
    { total_distance: @rides.sum(:distance), total_price: @rides.sum(:price) }
  end

  def serialize_monthly
    distance = @rides.sum(:distance)

    distance.map do |date, ride|
      { day: date.strftime("%B, #{date.day.ordinalize}"),
        total_distance: "#{ride}km",
        avg_ride: "#{@rides.average(:distance)[date]}km",
        avg_price: "#{@rides.average(:price)[date]}PLN" }
    end.compact
  end
end