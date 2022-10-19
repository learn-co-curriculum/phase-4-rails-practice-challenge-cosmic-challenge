class PlanetsController < ApplicationController

    def index
        planets = Planet.all
        render json: planets, status: :ok
    end

end
