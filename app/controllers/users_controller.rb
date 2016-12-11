class UsersController < ApplicationController
  before_action :must_be_proprietary, only: [:edit, :update]

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    @user.gen_token_and_salt
    if @user.save
      log_in_session(@user)
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
    end
  end

  def edit
    @user = current_logged_user
    @address = Address.new()
    if !@user
      render_404
    end
  end

  def update

  end

  def user_params
    params.require(:user).permit(:name, :lastname, :mail, :password, :password_confirmation)
  end
end
