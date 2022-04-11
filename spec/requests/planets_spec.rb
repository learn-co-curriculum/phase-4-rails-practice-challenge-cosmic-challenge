require 'rails_helper'

RSpec.describe "Planets", type: :request do

  before do
    planet1 = Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")
    planet2 = Planet.create(name: "Maxxor", distance_from_earth: "9 parsecs", nearest_star: "Canus Minor", image: "planet7")
  end

  describe "GET /index" do
    it "returns an array of all planets" do
      get '/planets'

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "TauCeti E", 
          distance_from_earth: "12 light years", 
          nearest_star: "TauCeti", 
          image: "planet3"
        },
        {
          id: a_kind_of(Integer),
          name: "Maxxor", 
          distance_from_earth: "9 parsecs", 
          nearest_star: "Canus Minor", 
          image: "planet7"
        }
      ])
    end

    it 'returns a status of 200 (OK)' do
      get '/planets'
      expect(response).to have_http_status(:ok)
    end
  end

end
