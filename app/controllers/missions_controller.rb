class MissionsController < ApplicationController

    def create
        mission = Mission.create(mission_params)
        if mission.valid?
            render json: mission.planet, status: :created
        else
            render json: { errors: mission.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

end
