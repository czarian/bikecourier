class Ride < ApplicationRecord
  validates :price, numericality: { only_float: true, message: 'Price should be number' }
  validates :distance, numericality: { only_float: true, message: 'Invalid one of the addresses' }
  validates_format_of :address_start, :address_end, with: /\A[a-zA-Z\s\dąćęłóńśźżĄĆĘŁÓŚŹŻ]*\s[0-9]*,\s[a-zA-Z\d\sąćęłóńśźżĄĆĘŁÓŚŹŻ]*,\s[a-zA-z\sąćęłóńśźżĄĆĘŁÓŚŹŻ]*\z/

  def self.this_week
    where("date >= ?", Time.zone.now.beginning_of_week)
  end

  def self.weekly
    select("date, COALESCE(SUM(rides.distance), 0) as total_distance,
            COALESCE(SUM(rides.price), 0) as total_price").this_week.first
  end

  def self.this_month
    where("created_at >= ?", Time.zone.now.beginning_of_month)
  end

  def self.monthly
    select("date, SUM(rides.distance) as total_distance,
            AVG(rides.distance) as avarage_distance,
            AVG(rides.price) as avarage_price").this_month.group("date(date)")
  end
end
