class UsersGroupsController < ApplicationController
  before_action :must_be_proprietary, only: [:index, :new, :create, :update, :delete, :destroy]

  def index
    @groups = current_logged_user.users_groups
  end

  def new
    @group = UsersGroup.new
  end

  def create
    @group = UsersGroup.new(users_group_params)
    @group.gen_token_and_salt
    if @group.save
      group_member = GroupMember.new
      group_member.user = current_logged_user
      group_member.users_group = @group
      group_member.is_creator = true
      if group_member.save
        render 'new'
      end
    else
      flash.now[:danger] = "An error occurred while creating your group."
      render 'new'
    end
  end

  def show
    user = User.find_by(id: params[:user_id])
    if user
      @group = user.users_groups.find_by(id: params[:id])
      if !@group
        render_404
      end
    else
      render_404
    end
  end

  def list
    @groups = UsersGroup.all
  end

  def users_group_params
    params.require(:users_group).permit(:name, :tag, :password, :user_id)
  end

end
