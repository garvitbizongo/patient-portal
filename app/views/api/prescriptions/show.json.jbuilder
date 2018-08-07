json.id @prescription.id
json.patient_id @prescription.patient_id
json.patient_name @prescription.patient.name
json.prescription_details @prescription.prescription_details

json.prescription_requests @prescription.prescription_requests do |request|
  json.id request.id
  json.status request.status
  json.doctor_pharmacist_name request.doctor_pharmacist.name
end
