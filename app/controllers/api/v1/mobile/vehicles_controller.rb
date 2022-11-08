class Api::V1::Mobile::VehiclesController < ApiController
  before_action :set_vehicle, only: %i[show]
  skip_before_action :doorkeeper_authorize!

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.all
    render json: @vehicles
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
    render json: @vehicle
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vehicle_params
    params.require(:vehicle)
  end
end
