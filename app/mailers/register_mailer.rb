class RegisterMailer < ApplicationMailer
  default from: Rails.application.secrets.mail_user

  def welcome(user)
    @user = user
    @mail_title = "Welcome @GGC ! 🎮"
    mail(to: @user.mail, subject: @mail_title)
  end

end
