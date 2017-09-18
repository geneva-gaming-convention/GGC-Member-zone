class RegistrationMailer < ApplicationMailer
  default from: Rails.application.secrets.mail_user

  def send_ticket(user, event)
    @user = user
    @event = event
    @mail_title = @event.shortname+" Tickets 🎟"
    @registration = @user.registrations.find_by(event: @event)
    if @event && @registration && @registration.token
      mail(to: @user.mail, subject: @mail_title)
    end
  end
end
