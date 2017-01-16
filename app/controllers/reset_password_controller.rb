class ResetPasswordController < ApplicationController

  def ask_reset_password
    @user = User.new
    render 'ask_reset_password', layout: "login"
  end

  def send_new_password
    @user = User.find_by(mail: user_params["mail"])
    if @user
      flash[:success] = "You will receive a new password very soon by mail ! ✅ (not ready yet)"
      redirect_to ask_rst_passwd_path
    else
      render_404
    end
  end

  def reset_password

  end

  def user_params
    params.require(:user).permit(:mail)
  end

end
