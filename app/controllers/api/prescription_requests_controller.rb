class Api::PrescriptionRequestsController < Api::ApiController
  before_action :authenticate_patient!

  def index
    @prescription_requests = PrescriptionRequest.filter(filter_params)
  end

  def update
    @prescription_request = PrescriptionRequest.find_by_id(params[:id])

    render json: { errors: "Prescription request not found for the given id" }, status: :bad_request if @prescription_request.blank?

    @prescription_request.assign_attributes(update_params)

    if @prescription_request.save
      render json: { }, status: :ok
    else
      render json: { errors: @prescription_request.errors.full_messages }, status: :bad_request
    end
  end

  private

  def filter_params
    params.permit(
      :patient_id,
      :prescription_id,
      :doctor_pharmacist_id
    )
  end

  def update_params
    params.permit(
      :status
    )
  end
end
