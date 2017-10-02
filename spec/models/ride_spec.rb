require 'rails_helper'
RSpec.describe Ride, :type => :model do

  let(:start_address) { 'Plac Europejski 2, Warszawa, Polska' }
  let(:destination_address) { 'Plac Zamkowy 2, Warszawa, Polska' }
  let(:distance) { 3 }
  let(:price) { 35 }

  it 'creates new ride' do
    expect { described_class.create(address_start: start_address,
                                    address_end: destination_address,
                                    distance: distance,
                                    price: price) }.to change { described_class.count }.by(1)
  end

  context 'when start and destination address are invalid' do
    let(:start_address) { 'Plac Europejski 2 Warszawa, Polska' }
    let(:destination_address) { 'Bad address' }

    it 'not creates new ride' do
      expect { described_class.create(address_start: start_address,
                                      address_end: destination_address,
                                      distance: distance,
                                      price: price) }.to_not change { described_class.count }
    end
  end

  context 'when start and destincation address are empty' do
    let(:start_address) { '' }
    let(:destination_address) { '' }

    it 'not create new ride' do
      expect { described_class.create(address_start: start_address,
                                      address_end: destination_address,
                                      distance: distance,
                                      price: price) }.to_not change { described_class.count }
    end
  end

  context 'when distance is invalid' do
    let(:distance) { '44ds' }

    it 'not create new ride' do
      expect { described_class.create(address_start: start_address,
                                      address_end: destination_address,
                                      distance: distance,
                                      price: price) }.to_not change { described_class.count }
    end
  end

  context 'when price is invalid' do
    let(:price) { '44ds' }

    it 'not create new ride' do
      expect { described_class.create(address_start: start_address,
                                      address_end: destination_address,
                                      distance: distance,
                                      price: price) }.to_not change { described_class.count }
    end
  end
end
