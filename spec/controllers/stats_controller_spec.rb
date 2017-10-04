require 'rails_helper'

RSpec.describe Api::StatsController, type: :controller do
  context 'weekly stats' do
    before do
      create_list(:ride, 3)
    end

    describe 'index' do
      it 'gets status ok' do
        response = get :index, { params: { period: 'weekly' } }
        expect(response).to have_http_status(:ok)
      end

      it 'gets index weekly stats' do
        response = get :index, { params: { period: 'weekly' } }
        json_response = JSON.parse(response.body)

        expect(json_response).to include(
                                   "total_distance" => be_a_kind_of(Float),
                                   "total_price" => be_a_kind_of(Float)
                                 )

      end

      it 'get non zero values from' do
        response = get :index, { params: { period: 'weekly' } }
        json_response = JSON.parse(response.body)
        expect(json_response).to include(
                                   "total_distance" => be > 0,
                                   "total_price" => be > 0
                                 )
      end
    end
  end

  context 'monthly stats' do

    before do
      new_time = Time.local(2017, 10, 03, 12, 0, 0)
      Timecop.freeze(new_time)
    end

    after do
      Timecop.return
    end

    let!(:today_rides) { create_list(:ride, 3, date: DateTime.now, distance: 2, price: 22) }
    let!(:beggining_of_month) { create_list(:ride, 3, date: Date.today.at_beginning_of_month, distance: 3, price: 33) }

    it 'gets monthly stats' do
      response = get :index, { params: { period: 'monthly' } }

      json_response = JSON.parse(response.body)

      expect(json_response).to include({
                                         "day" => "October, 1st",
                                         "total_distance" => "9.0km",
                                         "avg_ride" => "3.0km",
                                         "avg_price" => "33.0PLN"
                                       },
                                       {
                                         "day" => "October, 3rd",
                                         "total_distance" => "6.0km",
                                         "avg_ride" => "2.0km",
                                         "avg_price" => "22.0PLN"
                                       }
                               )
    end
  end

  context 'without creating' do
    describe 'index' do
      it 'gets status ok' do
        response = get :index, { params: { period: 'weekly' } }
        expect(response).to have_http_status(:ok)
      end

      it 'gets empty list' do
        response = get :index, { params: { period: 'weekly' } }
        json_response = JSON.parse(response.body)

        expect(json_response).to include(
                                   "total_distance" => be = 0,
                                   "total_price" => be = 0
                                 )
      end
    end
  end
end