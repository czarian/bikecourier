require 'rails_helper'

RSpec.describe Api::RidesController, type: :controller do
  let(:params) { { address_start: 'Plac Europejski 2, Warszawa, Polska',
                   address_end: 'Plac Zamkowy 2, Warszawa, Polska',
                   price: 33.5,
                   date: DateTime.now } }


  it 'creates new ride' do
    response = post :create, { params: { ride: params } }

    expect(response).to have_http_status(:created)
  end

  context 'with invalid address' do
    let(:params) { { address_start: 'Nie ma takiego bicia, Warszawa, Polska',
                     address_end: 'Plac Zamkowy 2, Warszawa, Polska',
                     price: 33.5,
                     date: DateTime.now } }

    it 'not create and render status rejected' do
      response = post :create, { params: { ride: params } }

      expect(response).to have_http_status(:bad_request)
    end

    it 'renders error message' do
      response = post :create, { params: { ride: params } }

      json_response = JSON.parse(response.body)

      expect(json_response["error"]).not_to be_empty
    end
  end
end
