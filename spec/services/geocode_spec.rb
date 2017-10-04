require 'rails_helper'

RSpec.describe Geocode do
  let(:start_address) { 'Plac europejski 2, Warszawa, Polska' }
  let(:destination_address) { 'Plac zamkowy 1, Warszawa, Polska' }

  it 'returns valid distance' do
    response = described_class.new(start_address, destination_address).call
    expect(response).to be_a_kind_of(Float)
  end

  context 'with invalid address' do
    let(:start_address) { 'Nie ma takiego adresu, Warszawa, Polska' }
    let(:destination_address) { 'Plac zamkowy 1, Warszawa, Polska' }

    it 'returns empty' do
      response = described_class.new(start_address, destination_address).call
      expect(response).to eq(nil)
    end
  end
end