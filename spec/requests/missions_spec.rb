require 'rails_helper'

RSpec.describe "Missions", type: :request do
  
  before do
    scientist = Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")
    planet1 = Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")
    Planet.create(name: "Maxxor", distance_from_earth: "9 parsecs", nearest_star: "Canus Minor", image: "planet7")
    Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet1.id)
  end

  describe "POST /missions" do

    context 'with valid data' do
      let!(:mission_params) {{name: "Project Terraform", scientist_id: Scientist.first.id, planet_id: Planet.second.id}}

      it 'creates a new Mission' do
        expect { post '/missions', params: mission_params}.to change(Mission, :count).by(1)
      end

      it 'returns the associated Planet data' do
        post '/missions', params: mission_params
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Maxxor", 
          distance_from_earth: "9 parsecs", 
          nearest_star: "Canus Minor", 
          image: "planet7"
        })
      end

      it 'returns a status code of 201 (created)' do
        post '/missions', params: mission_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let!(:mission_params) {{name: "Operation Phoenix", scientist_id: Scientist.first.id, planet_id: Planet.first.id}}

      it 'does not creates a new Mission' do
        expect { post '/missions', params: mission_params}.to change(Mission, :count).by(0)
      end
  
      it 'returns the error messages' do
        post '/missions', params: mission_params
  
        expect(response.body).to include_json({
          errors: a_kind_of(Array)
        })
      end
  
      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/missions', params: mission_params
  
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end


  end
end

