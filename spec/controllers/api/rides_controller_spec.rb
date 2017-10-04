require 'rails_helper'

RSpec.describe Api::RidesController, type: :controller do
  let(:params) do
    { start_address: 'Plac Europejski 2, Warszawa, Polska',
      destination_address: 'Plac Zamkowy 2, Warszawa, Polska' }
  end

  it 'creates new ride' do
    response = post :create, { params: { activity: params } }

    expect(response).to have_http_status(:created)
  end
end
