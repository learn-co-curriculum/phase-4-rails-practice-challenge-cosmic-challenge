require "rails_helper"

RSpec.describe PlanetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/planets").to route_to("planets#index")
    end

    it "routes to #show" do
      expect(get: "/planets/1").to route_to("planets#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/planets").to route_to("planets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/planets/1").to route_to("planets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/planets/1").to route_to("planets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/planets/1").to route_to("planets#destroy", id: "1")
    end
  end
end
