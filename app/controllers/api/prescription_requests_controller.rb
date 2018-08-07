class Api::PrescriptionRequestsController < Api::ApiController
  before_action :authenticate_patient!

  def index
    @prescription_requests = PrescriptionRequest.filter(filter_params)
  end

  private

  def filter_params
    params.permit(
      :patient_id,
      :prescription_id,
      :doctor_pharmacist_id
    )
  end
end
