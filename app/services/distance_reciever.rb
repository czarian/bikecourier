require 'google_maps_service'

class DistanceReciever
  def initialize(start_address, destination_address)
    @gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_KEY'])

    @start_address = coords(start_address)
    @destination_address = coords(destination_address)
  end

  def call
    return unless @start_address && @destination_address
    distance
  end

  def distance
    distance = @gmaps.distance_matrix(@start_address, @destination_address,
                                      mode: 'driving',
                                      language: 'en-AU',
                                      units: 'metric')

    distance[:rows].first[:elements].first[:distance][:value].fdiv(1000)
  end

  def coords(address)
    coords = @gmaps.geocode(address).first
    return unless coords

    coords.dig(:geometry, :location)
  end
end
