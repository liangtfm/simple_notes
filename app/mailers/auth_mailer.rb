class AuthMailer < ActionMailer::Base
  default from: "anthony@simplenotes.co"

  def signup_email(user)
    @user = user
    @token = @user.auth_token
    @url = "http://simplenotes.co/users/#{@user.id}/activate?auth_token=#{@token}"

    mail(
      :to => user.email,
      :subject => 'Thanks for signing up! Please confirm your account.'
    )
  end
end
