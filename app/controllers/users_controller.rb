class UsersController < ApplicationController
  before_action :must_be_proprietary, only: [:edit, :update, :delete, :destroy]

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    @user.gen_token_and_salt
    if @user.save
      log_in_session(@user)
      RegisterMailer.welcome(@user).deliver_now
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] =  "Failed to create "+@user.name + ", check every fields."
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params["id"])
    if !@user
      render_404
      return
    end
    @is_account_valid = @user.address && @user.validated
  end

  def edit
    @user = current_logged_user
    @address = Address.new()
    if !@user
      render_404
      return
    end
  end

  def update

  end

  def delete
    @user = current_logged_user
  end

  def destroy
    @user = current_logged_user
    if @user.destroy && log_out
      redirect_to root_path
    else
      flash[:danger] =  "Failed to delete your account 😞"
      redirect_to edit_user_path(@user.id)
    end
  end

  def validate
    user = User.find_by(token: params["token"])
    if user
      user.validated = true
      user.password_confirmation = user.password
      if user.save
        user.gen_token
        user.password_confirmation = user.password
        if user.save
          flash[:success] = 'Your email has been validated sucessfully !'
          redirect_to login_path
        else
          flash[:danger] = 'Your email has not been validated, try again.'
          redirect_to login_path
        end
      else
        flash[:danger] = 'Your email has not been validated, try again.'
        redirect_to login_path
      end
    else
      render_404
    end
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :mail, :password, :password_confirmation)
  end
end
