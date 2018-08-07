module PrescriptionRequestServices
  class CreatePrescriptionRequest
    def initialize(context)
      @context = Hashie::Mash.new context
      @prescription_id = @context.prescription_id
      @doctor_pharmacist_id = @context.doctor_pharmacist_id
      @context.errors = []
    end

    def execute
      begin
        validate

        if @context.errors.blank?
          create
        else
          @context.errors
        end

        return @context
      rescue => e
        @context.errors << e.message
        return @context
      end
    end

    private

    def validate
      @prescription = Prescription.find_by_id(@prescription_id)
      @doctor_pharmacist = DoctorPharmacist.find_by_id(@doctor_pharmacist_id)

      @context.errors << "Prescription not found for the given id while creating prescription request." if @prescription.blank?
      @context.errors << "Doctor/Pharmacist not found for the given id while creating prescription request." if @doctor_pharmacist.blank?
    end

    def create
      prescription_request = PrescriptionRequest.new
      prescription_request.prescription_id = @prescription_id
      prescription_request.doctor_pharmacist_id = @doctor_pharmacist_id

      if prescription_request.save
        return true
      else
        @context.errors << prescription_request.errors.full_messages
      end
    end
  end
end
