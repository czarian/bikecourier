class Ride < ApplicationRecord
  validates :price, numericality: { only_float: true, message: 'Price should be number' }
  validates :distance, numericality: { only_float: true, message: 'Invalid one of the addresses' }
  validates_format_of :address_start, :address_end, with: /\A[a-zA-Z\s\dąćęłóńśźżĄĆĘŁÓŚŹŻ]*\s[0-9]*,\s[a-zA-Z\d\sąćęłóńśźżĄĆĘŁÓŚŹŻ]*,\s[a-zA-z\sąćęłóńśźżĄĆĘŁÓŚŹŻ]*\z/
end
