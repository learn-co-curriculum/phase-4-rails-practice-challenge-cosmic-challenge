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

    it "does not include associated planet data" do
      get '/scientists'

      expect(response.body).not_to include_json([
        {
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

  describe "POST /scientists" do

    context 'with valid data' do
      let!(:scientist_params) {{name: "Evan T'Horizon", field_of_study: "astronavigation", avatar: "https://robohash.org/evan_thorizon?set=set5"}}

      it 'creates a new Scientist' do
        expect { post '/scientists', params: scientist_params}.to change(Scientist, :count).by(1)
      end

      it 'returns the associated Scientist data' do
        post '/scientists', params: scientist_params
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Evan T'Horizon", 
          field_of_study: "astronavigation", 
          avatar: "https://robohash.org/evan_thorizon?set=set5"
        })
      end

      it 'returns a status code of 201 (created)' do
        post '/scientists', params: scientist_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let!(:scientist_params) {{name: "P. Legrange"}}

      it 'does not creates a new Scientist' do
        expect { post '/scientists', params: scientist_params}.to change(Scientist, :count).by(0)
      end
  
      it 'returns the error messages' do
        post '/scientists', params: scientist_params
  
        expect(response.body).to include_json({
          errors: a_kind_of(Array)
        })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/scientists', params: scientist_params
  
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  describe "PATCH /scientists" do

    context 'with valid data' do
      let!(:scientist_params) {{name: "Bevan T'Horizon", field_of_study: "warp drive tech", avatar: "https://robohash.org/bevan_thorizon?set=set5"}}

      it 'returns the associated Scientist data' do
        patch "/scientists/#{Scientist.second.id}", params: scientist_params
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Bevan T'Horizon", 
          field_of_study: "warp drive tech", 
          avatar: "https://robohash.org/bevan_thorizon?set=set5"
        })
      end

      it 'returns a status code of 202 (accepted)' do
        patch "/scientists/#{Scientist.second.id}", params: scientist_params

        expect(response).to have_http_status(:accepted)
      end
    end

    context 'with invalid data' do
      let!(:scientist_params) {{name: "P. Legrange", field_of_study: ""}}

      it 'returns the error messages' do
        patch "/scientists/#{Scientist.second.id}", params: scientist_params
  
        expect(response.body).to include_json({
          errors: a_kind_of(Array)
        })
      end
  
      it 'returns a status code of 422 (Unprocessable Entity)' do
        patch "/scientists/#{Scientist.second.id}", params: scientist_params
  
        expect(response).to have_http_status(:unprocessable_entity)
      end


    end

    context 'with invalid ID' do
      let!(:scientist_params) {{name: "Bevan T'Horizon", field_of_study: "warp drive tech", avatar: "https://robohash.org/bevan_thorizon?set=set5"}}

      it 'returns the error message' do
        patch "/scientists/bad_id", params: scientist_params
        expect(response.body).to include_json({
          error: "Scientist not found"
        })
      end

      it "returns the appropriate HTTP status code" do
        patch "/scientists/bad_id", params: scientist_params
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  describe "DELETE /scientists/:id" do

    context "with a valid ID" do

      it "deletes the Scientist" do
        expect { delete "/scientists/#{Scientist.first.id}" }.to change(Scientist, :count).by(-1)
      end

      it "deletes the associated Missions" do
        count = Scientist.first.missions.count
        expect { delete "/scientists/#{Scientist.first.id}" }.to change(Mission, :count).by(-count)
      end

    end

    context "with an invalid ID" do
      
      it "returns an error message" do
        delete "/scientists/bad_id"

        expect(response.body).to include_json({
          error: "Scientist not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        delete "/scientists/bad_id"

        expect(response).to have_http_status(:not_found)
      end

    end

  end
end
