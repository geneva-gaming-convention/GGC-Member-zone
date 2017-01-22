class ResetPasswordController < ApplicationController

  def ask_reset_password
    @user = User.new
    render 'ask_reset_password', layout: "login"
  end

  def send_new_password
    @user = User.find_by(mail: user_params["mail"])
    if @user
      @user.gen_reset_token
      @user.password_confirmation = @user.password
      if @user.save && ResetPasswordMailer.reset_password(@user).deliver_now
        flash[:success] = "You will receive a new password very soon by mail ! ✅"
        redirect_to ask_rst_passwd_path
      else
        flash[:danger] = "Failure during your password reset process ! 😩"
        redirect_to ask_rst_passwd_path
      end
    else
      render_404
    end
  end

  def config_new_password
    @user = User.find_by(reset_token: params["token"])
    if @user && @user.reseted_at > DateTime.now-(24.hour)
      render 'config_new_password'
    else
      flash[:danger] = "Failure during your password configuration process ! Try again."
      redirect_to ask_rst_passwd_path
    end
  end

  def reset_password
    @user = User.find_by(reset_token: params["token"])
    if @user && @user.reseted_at > DateTime.now-(24.hour)
      @user.password = user_params["password"]
      @user.password_confirmation = user_params["password_confirmation"]
      if @user.password == @user.password_confirmation && @user.password != ""
        @user.gen_token_and_salt
        @user.change_password(@user.password)
        if @user.gen_reset_token && @user.save
          flash[:success] = "Your password has been updated !"
          redirect_to login_path
        else
          flash[:danger] = "Failure during your password configuration process ! "+@user.errors.full_messages.to_sentence
          redirect_to conf_new_passwd_path(params["token"])
        end
      else
        flash[:danger] = "Failure during your password configuration process ! "
        redirect_to conf_new_passwd_path(params["token"])
      end
    else
      flash[:danger] = "Failure during your password configuration process !"
      redirect_to ask_rst_passwd_path
    end
  end

  def user_params
    params.require(:user).permit(:mail, :password, :password_confirmation)
  end

end
