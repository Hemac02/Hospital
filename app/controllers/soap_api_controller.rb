class SoapApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_patient
    # Extract raw SOAP XML
    raw_xml = request.body.read

    # Parse SOAP XML into a Ruby hash
    xml_hash = Hash.from_xml(raw_xml)

    # Navigate inside the SOAP structure
    body = xml_hash["Envelope"]["Body"]
    data = body["create_patient"] || body["tns:create_patient"]


        # Extract fields
    first_name   = data["firstName"]
    middle_name  = data["middleName"]
    last_name    = data["lastName"]
    phone        = data["phone"]
    email        = data["email"]
    address      = data["address"]
    health_issue = data["healthIssue"]
    diagnosis    = data["diagnosis"]

    # ⭐ Save into your DB (patient_regs table)
    PatientReg.create(
      FirstName: first_name,
      MiddleName: middle_name,
      LastName: last_name,
      Phone: phone,
      Email: email,
      Address: address,
      Health_issue: health_issue,
      Diagnosis: diagnosis
    )

    render xml: %(
      <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
          <createPatientResponse>
            <status>Success</status>
            <receivedFirstName>#{first_name}</receivedFirstName>
            <receivedLastName>#{last_name}</receivedLastName>
          </createPatientResponse>
        </soap:Body>
      </soap:Envelope>
    )
  end

  def wsdl
    render xml: File.read(Rails.root.join("public", "patient_service.wsdl"))
  end
end
