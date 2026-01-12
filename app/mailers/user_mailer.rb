class UserMailer < ApplicationMailer
  def verify_email(user)
    @user = user
    @url = verify_email_url(token: user.email_verification_token)

    mail(
      to: @user.email,
      subject: "Verify your email"
    )
  end
end
