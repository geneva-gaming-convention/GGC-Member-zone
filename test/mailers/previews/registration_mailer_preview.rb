# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  def send_ticket
    RegistrationMailer.send_ticket(User.first, Event.last)
  end
end
