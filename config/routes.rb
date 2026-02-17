Rails.application.routes.draw do
  # Root page → login
  root "sessions#new"

  # Login routes
  get  "login",  to: "sessions#new"
  post "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Patient registration routes
  resources :patient_regs, only: [:new, :create, :show]

  # SOAP routes 
  post "/soap/create_patient", to: "soap_api#create_patient"
  get  "/soap/wsdl",           to: "soap_api#wsdl"
end
