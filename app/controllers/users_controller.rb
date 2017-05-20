class UsersController < ApplicationController
  before_action :must_be_proprietary, only: [:edit, :update, :update_phone, :delete_phone, :delete, :destroy, :ask_validation]

  ##
  # Initialise an empty user model and display the user's creation form
  #
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
      flash.now[:danger] =  "Failed to create "+@user.name + ", "+@user.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params["id"])
    if !@user
      render_404
      return
    end
    @is_account_valid = is_ready_for_registration
  end

  def edit
    @user = current_logged_user
    @address = Address.new()
    if !@user
      render_404
    end
  end

  def update
    @user = User.find(params[:id])
    old_mail = @user.mail
    if @user.update_attributes(user_params)
      @user.password = user_params["password"]
      @user.password_confirmation = user_params["password_confirmation"]
      @user.gen_token_and_salt
      @user.change_password(@user.password)
      if old_mail != user_params["mail"]
        @user.validated = false
      end
      if @user.save
        if @user.validated == false
          RegisterMailer.welcome(@user).deliver_now
        end
        flash[:success] = "Your personnal informations have successfully been updated"
        redirect_to edit_user_path(@user.id)
      else
        flash.now[:danger] = "An error occurred while updating your personal informations, "+@user.errors.full_messages.to_sentence
        render 'edit'
      end
    else
      flash.now[:danger] = "An error occurred while updating your personal informations, "+@user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def update_phone
    @user = User.find(params[:user_id])
    if @user && user_params[:phone].mb_chars.length >= 10
      @user.password_confirmation = @user.password
      @user.phone = user_params[:phone]
      if @user.update_attributes(user_params)
        msg = "Your new phone number have successfully been updated"
        flash[:success] = msg
        redirect_to edit_user_path(@user.id)
      else
        msg = "An error occurred while updating your phone number, "+@user.errors.full_messages.to_sentence
        flash.now[:danger] = msg
        render 'edit'
      end
    else
      msg = "An error occurred while updating your phone number"
      flash.now[:danger] = msg
      render 'edit'
    end
  end

  def delete_phone
    @user = User.find(params[:user_id])
    if @user
      @user.phone = nil
      @user.password_confirmation = @user.password
      if @user.save
        msg = "Your phone number has been deleted"
        flash[:success] = msg
        redirect_to edit_user_path(@user.id)
      else
        msg = "An error occurred while deleting your phone number"
        flash.now[:danger] = msg
        render 'edit'
      end
    else
      flash.now[:danger] = "User asked not found"
      render_404
    end
  end

  def delete
    @user = current_logged_user
  end

  def destroy
    @user = current_logged_user
    if @user.destroy && log_out
      redirect_to root_path
    else
      flash[:danger] =  "Failed to delete your account 😞, "+@user.errors.full_messages.to_sentence
      redirect_to user_delete_path(@user.id)
    end
  end

  def ask_validation
    @user = current_logged_user
    if RegisterMailer.welcome(@user).deliver_now
      flash[:success] =  "A new validation mail has been sent"
    else
      flash[:danger] =  "Failed while send a new validation mail 😞"
    end
    redirect_to edit_user_path(@user.id)
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
      flash.now[:danger] = "User asked not found"
      render_404
    end
  end

  def auth_failure
    flash[:danger] = params[:message]
    redirect_to edit_user_path(current_logged_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :mail, :phone, :password, :password_confirmation)
  end
end
