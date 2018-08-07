class Api::DoctorPharmacist::PrescriptionsController < Api::DoctorPharmacist::ApiController
  before_action :authenticate_doctor_pharmacist!

  def show
    @prescription = Prescription.find_by_id(params[:id])

    render json: { errors: "Prescription not found for the given id" }, status: :bad_request if @prescription.blank?
  end
end
