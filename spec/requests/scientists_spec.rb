require 'rails_helper'

RSpec.describe "Scientists", type: :request do
  before do
    scientist1 = Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")
    scientist2 = Scientist.create(name: "P. Legrange", field_of_study: "orbital mechanics", avatar: "https://robohash.org/p_legrange?set=set5")
    planet1 = Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")
    planet2 = Planet.create(name: "Maxxor", distance_from_earth: "9 parsecs", nearest_star: "Canus Minor", image: "planet7")
    Mission.create(name: "Project Astrophage", scientist_id: scientist1.id, planet_id: planet1.id)
    Mission.create(name: "Project Terraform", scientist_id: scientist1.id, planet_id: planet2.id)
    Mission.create(name: "Project Terraform", scientist_id: scientist2.id, planet_id: planet2.id)
  end

  describe "GET /index" do
    it "returns an array of all scientists" do
      get '/scientists'

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "Mel T. Valent", 
          field_of_study: "xenobiology", 
          avatar: "https://robohash.org/mel_t_valent?set=set5"
        },
        {
          id: a_kind_of(Integer),
          name: "P. Legrange", 
          field_of_study: "orbital mechanics", 
          avatar: "https://robohash.org/p_legrange?set=set5"
        }
      ])
    end

    it 'returns a status of 200 (OK)' do
      get '/scientists'
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "GET /scientists/:id" do
    
    context 'with a valid ID' do
      
      it "returns the matching scientist with their associated planets" do
        get "/scientists/#{Scientist.first.id}"
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Mel T. Valent", 
          field_of_study: "xenobiology", 
          avatar: "https://robohash.org/mel_t_valent?set=set5",
          planets: [
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
          ]
        })
      end

      it 'returns a status of 200 (OK)' do
        get "/scientists/#{Scientist.first.id}"
        expect(response).to have_http_status(:ok)
      end

    end

    context 'with an invalid ID' do

      it "returns an error message" do
        get "/scientists/bad_id"
        expect(response.body).to include_json({
          error: "Scientist not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        get "/scientists/bad_id"
        expect(response).to have_http_status(:not_found)
      end
      
    end
  end
end
