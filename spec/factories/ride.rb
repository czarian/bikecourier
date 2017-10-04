FactoryGirl.define do
  factory :ride do
    address_start 'Plac Europejski 2, Warszawa, Polska'
    address_end 'Plac zamkowy 1, Warszawa, Polska'
    distance 2.5
    price 45
    date DateTime.now
  end
end