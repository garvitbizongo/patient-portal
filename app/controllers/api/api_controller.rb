class Api::ApiController < ActionController::Base

  def auth
    unless valid_secret_token?
      render json: { error: "Invalid Secret Token" }, status: :unauthorized
      return
    end

    email, password = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    patient = Patient.find_by_email(email)

    if patient.blank?
      render json: { error: "Patient with email: #{email} not found!"}, status: :not_found
      return
    end

    if patient.inactive?
      render json: { error: "Patient with email: #{email} is currently inactive!"}, status: :unauthorized
      return
    end

    render json: { error: "Invalid Password" }, status: :unauthorized unless patient.valid_password?(password)

    @logging_in_patient = patient
  end

  protected

  def authenticate_patient!
    authenticate_or_request_with_http_token do |token, options|
      @patient = Patient.find_by_auth_token(token)

      if @patient && @patient.active?
        # Notice we are passing store false, so the user is not
        # actually stored in the session and a token is needed
        # for every request. If you want the token to work as a
        # sign in token, you can simply remove store: false.
        sign_in @patient, store: false
      else
        false
      end
    end
    logger.info admin_backend_text_log({company: "Bizongo", action: (controller_name.camelize + action_name.camelize) + "Admin" }) if @admin_user.present?
  end

  private

  def valid_secret_token?
    secret_token_received = request.headers['HTTP_SECRET_TOKEN']
    return false unless secret_token_received

    actual_secret_token = Rails.application.secrets.client_secret
    secret_token_received.eql?(actual_secret_token)
  end
end
