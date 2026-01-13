class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("GMAIL_USERNAME", "no-reply@umgundi.test")
  layout "mailer"
end
