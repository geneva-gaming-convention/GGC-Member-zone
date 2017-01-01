# Preview all emails at http://localhost:3000/rails/mailers/register_mailer
class RegisterMailerPreview < ActionMailer::Preview
  def welcome
    RegisterMailer.welcome(User.first)
  end
end
