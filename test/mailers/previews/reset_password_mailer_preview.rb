# Preview all emails at http://localhost:3000/rails/mailers/reset_password_mailer
class ResetPasswordMailerPreview < ActionMailer::Preview
  def reset_password
    ResetPasswordMailer.reset_password(User.first)
  end
end
