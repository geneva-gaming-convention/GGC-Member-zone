class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mail_user
  layout 'mailer'
end
