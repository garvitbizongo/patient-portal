class Api::DoctorPharmacist::PrescriptionsController < Api::DoctorPharmacist::ApiController
  before_action :authenticate_doctor_pharmacist!

  def show
    @prescription = Prescription.find_by_id(params[:id])
    render json: { errors: "Prescription not found for the given id" }, status: :bad_request if @prescription.blank?

    @errors = []
    check_for_viewing_prescription

    render json: { errors: @errors.join(",") }, status: :bad_request if @errors.present?
  end

  private

  def check_for_viewing_prescription
    prescription_request = PrescriptionRequest.filter({prescription_id: @prescription.id, doctor_pharmacist_id: current_doc_pharma.id}).first

    if prescription_request.present? && prescription_request.unapproved?
      @errors << "The request you made for this prescription is pending. You can not view this prescription yet."
    elsif prescription_request.blank?
      create_prescription_request
    end
  end

  def create_prescription_request
    service_params = {
      prescription_id: @prescription.id,
      doctor_pharmacist_id: current_doc_pharma.id
    }
    context = ::PrescriptionRequestServices::CreatePrescriptionRequest.new(service_params).execute

    if context.errors.present?
      @errors << context.errors
    else
      @errors << "A request has been sent to patient. You can view this prescription when patient will approve the request."
    end
  end
end
