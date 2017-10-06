class StatSerializer
  def initialize(rides)
    @rides = rides
  end

  def serialize_weekly
    { total_distance: @rides.total_distance, total_price: @rides.total_price }
  end

  def serialize_monthly
    @rides.map do |ride|
      { day: ride.date.strftime("%B, #{ride.date.day.ordinalize}"),
            total_distance: "#{ride.total_distance}km",
            avg_ride: "#{ride.avarage_distance}km",
            avg_price: "#{ride.avarage_price}PLN" }
    end
  end
end