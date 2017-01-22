class ResetPasswordMailer < ApplicationMailer
  default from: Rails.application.secrets.mail_user

  def reset_password(user)
    @user = user
    @mail_title = "New GGC password ! 🔑"
    mail(to: @user.mail, subject: @mail_title)
  end

end
