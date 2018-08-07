json.prescription_requests @prescription_requests do |request|
  json.id request.id
  json.status request.status
  json.doctor_pharmacist_name request.doctor_pharmacist.name
end
