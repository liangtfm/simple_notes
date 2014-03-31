class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  private

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def sign_out
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

  def require_signed_out!
    redirect_to user_url(current_user) if signed_in?
  end

  def require_auth!
    redirect_to new_session_url unless current_user.activated == true
  end

  def send_text(receiver, body)
    twilio = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]

    twilio.account.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: receiver,
      body: body
    )
  end
end
