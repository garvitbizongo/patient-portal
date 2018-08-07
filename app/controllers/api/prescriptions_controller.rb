class Api::PrescriptionsController < Api::ApiController
  before_action :authenticate_patient!

  def show
    @prescription = Prescription.find_by_id(params[:id])

    render json: { errors: "Prescription not found for the given id" }, status: :bad_request if @prescription.blank?
  end
end
