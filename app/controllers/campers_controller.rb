class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def index
        render json: Camper.all, status: :ok, except: [:created_at, :updated_at], adapter: nil
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created, except: [:created_at, :updated_at], adapter: nil
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities, status: :ok
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_record_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
