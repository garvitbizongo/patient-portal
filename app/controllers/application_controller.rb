class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_patient
    if session[:user_id]
      PATIENT.find { |u| u.id == session[:patient_id] }
    else
      nil
    end
  end
end
