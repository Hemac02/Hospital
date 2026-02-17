class PatientRegsController < ApplicationController
  before_action :require_login
  hbdhb
  def new
    Rails.logger.info "📄 Registration Form — Session ID: #{request.session_options[:id]}"
    @patient_reg = PatientReg.new
  end

  def create
    Rails.logger.info "📝 Creating Record — Session ID: #{request.session_options[:id]}"
    @patient_reg = PatientReg.new(patient_reg_params)
    if @patient_reg.save
      send_to_soap(@patient_reg)   # ⭐ SOAP CALL ADDED HERE
      redirect_to patient_reg_path(@patient_reg), notice: "Patient saved & sent to SOAP service."
    else
      render :new
    end
  end

  def show
    Rails.logger.info "🎉 Success Page — Session ID: #{request.session_options[:id]}"
    @patient_reg = PatientReg.find(params[:id])
  end

  private
  # ⭐ KEEPING YOUR ORIGINAL FIELD NAMES SAME
  def patient_reg_params
    params.require(:patient_reg).permit(
      :FirstName, :MiddleName, :LastName,
      :Phone, :Email, :Address,
      :Health_issue, :Diagnosis
    )
  end

  # ⭐ SOAP METHOD (ONLY THIS IS NEW)
  def send_to_soap(patient)
    soap = MySoapClient.new

    message = {
      FirstName: patient.FirstName,
      MiddleName: patient.MiddleName,
      LastName: patient.LastName,
      Phone: patient.Phone,
      Email: patient.Email,
      Address: patient.Address,
      Health_issue: patient.Health_issue,
      Diagnosis: patient.Diagnosis
    }

    response = soap.call(:create_patient, message)
    Rails.logger.info "SOAP Response: #{response.body}"
  end

  def require_login
    unless session[:user_id]
      flash[:alert] = "Please login first."
      redirect_to login_path
    end
  end
end
