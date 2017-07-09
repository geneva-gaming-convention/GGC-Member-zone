class UsersGroupsController < ApplicationController
  before_action :must_be_proprietary, only: [:index, :new, :create, :update, :delete, :destroy]
  before_action :must_be_logged,      only: [:ask_to_join, :join, :ask_to_leave, :leave]

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
    @group = UsersGroup.find_by(id: params[:id])
    if !@group
      render_404
    end
  end

  def list
    @groups = UsersGroup.all
  end

  def ask_to_join
    @group = UsersGroup.find_by(id: params[:id])
    if !@group
      render_404
    end
  end

  def join
    @group = UsersGroup.find_by(id: params[:id])
    if !@group
      render_404
    elsif @group && @group.authenticate(users_group_params["password"])
      if !@group.is_user_already_group_member(current_logged_user)
        group_member = GroupMember.new
        group_member.user = current_logged_user
        group_member.users_group = @group
        group_member.is_creator = false
        if group_member.save
          flash.now[:success] = "Welcome :) !"
          redirect_to show_group_path(@group.id)
        else
          flash.now[:danger] = "An error occurred while joining this group. "+group_member.errors.full_messages.to_sentence
          render 'ask_to_join'
        end
      else
        flash.now[:warning] = "You're already in this group, genius :P !"
        render 'show'
      end
    else
      flash.now[:danger] = "An error occurred while joining this group. Credentials may be incorrect..."
      render 'ask_to_join'
    end
  end

  def ask_to_leave
    @group = UsersGroup.find_by(id: params[:id])
    if !@group
      render_404
    end
  end

  def leave
    @group = UsersGroup.find_by(id: params[:id])
    if @group
      if @group.is_user_already_group_member(current_logged_user)
        group_member = @group.group_members.find_by(user_id:current_logged_user.id)
        if group_member.destroy
          flash[:success] = "You're free :P, you successfully left "+@group.name
          redirect_to show_group_path(@group.id)
        else
          flash.now[:danger] = "An error occurred while leaving this group."+group_member.errors.full_messages.to_sentence
          render 'ask_to_leave'
        end
      end
    else
      render_404
    end
  end

  def users_group_params
    params.require(:users_group).permit(:name, :tag, :password, :user_id)
  end

end
