class Api::DoctorPharmacist::ApiController < ActionController::Base
  def auth
    unless valid_secret_token?
      render json: { error: "Invalid Secret Token" }, status: :unauthorized
      return
    end

    email, password = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    doctor_pharmacist = ::DoctorPharmacist.find_by_email(email)

    if doctor_pharmacist.blank?
      render json: { error: "Doctor/Pharmacist with email: #{email} not found!"}, status: :not_found
      return
    end

    if doctor_pharmacist.inactive?
      render json: { error: "Doctor/Pharmacist with email: #{email} is currently inactive!"}, status: :unauthorized
      return
    end

    render json: { error: "Invalid Password" }, status: :unauthorized unless doctor_pharmacist.test_password?(password)

    @logging_in_doctor_pharmacist = doctor_pharmacist
  end

  def current_doc_pharma
    if session[:doc_pharma_id]
      DoctorPharmacist.find_by_id(session[:doc_pharma_id])
    else
      nil
    end
  end

  protected

  def authenticate_doctor_pharmacist!
    authenticate_or_request_with_http_token do |token, options|
      @doctor_pharmacist = DoctorPharmacist.find_by_auth_token(token)

      if @doctor_pharmacist && @doctor_pharmacist.active?
        session[:doc_pharma_id] = nil
        session[:doc_pharma_id] = @doctor_pharmacist.id
      else
        false
      end
    end
  end

  private

  def valid_secret_token?
    secret_token_received = request.headers['HTTP_SECRET_TOKEN']
    return false unless secret_token_received

    actual_secret_token = Rails.application.secrets.client_secret
    secret_token_received.eql?(actual_secret_token)
  end
end
