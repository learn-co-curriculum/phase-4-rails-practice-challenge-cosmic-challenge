require 'rails_helper'

RSpec.describe Scientist, type: :model do
<<<<<<< HEAD
  pending "add some examples to (or delete) #{__FILE__}"
=======
  describe "relationships" do

    let(:scientist) {Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")}
    let(:planet) {Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")}

    it 'can access the associated missions' do
      mission = Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(scientist.missions).to include(mission)
    end

    it 'can access the associated planets' do
      Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(scientist.planets).to include(planet)
    end
  end

  describe "validations" do

    it "must have a name" do
      expect(Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_valid
      expect(Scientist.create(field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_invalid
    end
    
    it "must have a field_of_study" do
      expect(Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_valid
      expect(Scientist.create(name: "Mel T. Valent", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_invalid
    end
    
    it "must have a unique name" do
      expect(Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_valid
      expect(Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")).to be_invalid
    end

    
  end
>>>>>>> main
end
