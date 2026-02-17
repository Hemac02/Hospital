class SessionsController < ApplicationController
  def new
    Rails.logger.info "🟢 Session ID at Login Page: #{request.session_options[:id]}"
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.password == params[:password]
      session[:user_id] = user.id   # Store user in session
      Rails.logger.info "✅ Logged in! Session ID: #{request.session_options[:id]}"
      redirect_to new_patient_reg_path
    else
      flash[:alert] = "Invalid username or password"
      render :new
    end
  end
 
  hi
  def destroy
    Rails.logger.info "🔴 Logging out... Old Session ID: #{request.session_options[:id]}"
    reset_session   # clears session and regenerates new session ID
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
