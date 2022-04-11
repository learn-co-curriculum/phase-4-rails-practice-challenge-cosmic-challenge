require 'rails_helper'

RSpec.describe Mission, type: :model do
  
  let(:scientist) {Scientist.create(name: "Mel T. Valent", field_of_study: "xenobiology", avatar: "https://robohash.org/mel_t_valent?set=set5")}
  let(:planet) {Planet.create(name: "TauCeti E", distance_from_earth: "12 light years", nearest_star: "TauCeti", image: "planet3")}

  describe "relationships" do

    it 'can access the associated scientist' do
      mission = Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(mission.scientist).to eq(scientist)
    end

    it 'can access the associated planet' do
      mission = Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)

      expect(mission.planet).to eq(planet)
    end

  end

  describe "validations" do

    it "must have a name" do
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)).to be_valid
      expect(Mission.create(scientist_id: scientist.id, planet_id: planet.id)).to be_invalid
    end

    it "must have a scientist" do
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)).to be_valid
      expect(Mission.create(name: "Project Astrophage", planet_id: planet.id)).to be_invalid
    end

    it "must have a planet" do
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)).to be_valid
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id)).to be_invalid
    end

    it "must not allow a scientist to join the same mission twice" do
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)).to be_valid
      expect(Mission.create(name: "Project Astrophage", scientist_id: scientist.id, planet_id: planet.id)).to be_invalid
    end

  end

end
