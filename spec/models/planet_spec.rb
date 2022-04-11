require 'rails_helper'

RSpec.describe Planet, type: :model do
<<<<<<< HEAD
  pending "add some examples to (or delete) #{__FILE__}"
=======
  
  describe "relationships" do

    let(:scientist) {Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")}
    let(:planet) {Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")}

    it 'can access the associated missions' do
      mission = Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(planet.missions).to include(mission)
    end

    it 'can access the associated scientist' do
      Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(planet.scientists).to include(scientist)
    end

  end

>>>>>>> main
end
