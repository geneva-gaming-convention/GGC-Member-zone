class UsersGroupsController < ApplicationController
  before_action :must_be_group_proprietary, only: [:update, :destroy, :kick]
  before_action :must_be_logged,            only: [:index, :new, :create, :ask_to_join, :join, :ask_to_leave, :leave]

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
        flash[:success] = @group.name+" successfully created !"
        redirect_to users_group_path(@group.id)
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

  def update
    @group = UsersGroup.find_by(id: params[:id])
    if @group && @group.is_proprietary(current_logged_user)
      if users_group_params[:password] == ""
        @group.update_attributes(users_group_params.except(:password))
      else
        @group.update_attributes(users_group_params)
      end
      if @group.valid?
        if users_group_params[:password] !=""
          @group.change_password(users_group_params[:password])
          @group.gen_token
        end
        if @group.save
          flash[:success] = @group.name+" has been updated successfully."
          redirect_to users_group_path(@group.id)
        else
          render 'show'
        end
      else
        render 'show'
      end
    elsif @group && !@group.is_proprietary(current_logged_user)
      flash.now[:danger] = "You're not the group administrator. "
      render 'show'
    elsif !@group
      render_404
    end
  end

  def ask_to_join
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if !@group
      render_404
    end
  end

  def join
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if !@group
      render_404
    elsif @group && ( @group.authenticate(params[:token]) || (params.has_key?(:users_group) && params[:users_group].has_key?(:password) && @group.authenticate(users_group_params[:password])) )
      if !@group.is_user_already_group_member(current_logged_user)
        group_member = GroupMember.new
        group_member.user = current_logged_user
        group_member.users_group = @group
        group_member.is_creator = false
        if group_member.save
          flash[:success] = "Welcome :) !"
          redirect_to users_group_path(@group.id)
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
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if !@group
      render_404
    end
  end

  def leave
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if @group
      if @group.is_user_already_group_member(current_logged_user)
        group_member = @group.group_members.find_by(user_id:current_logged_user.id)
        if group_member.destroy
          flash[:success] = "You're free :P, you successfully left "+@group.name
          redirect_to users_group_path(@group.id)
        else
          render 'ask_to_leave'
        end
      end
    else
      render_404
    end
  end

  def ask_to_destroy
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if @group
      if !@group.is_proprietary(current_logged_user)
        flash.now[:danger] = "You're not the proprietary of this group, you can't delete it."
        render 'ask_to_destroy'
      end
    else
      render_404
    end
  end

  def destroy
    @group = UsersGroup.find_by(id: params[:id])
    if @group
      if @group.is_proprietary(current_logged_user)
        if @group.destroy
          flash[:success] = @group.name+" has been successfully deleted."
          redirect_to global_groups_list_path
        else
          flash.now[:danger] = "An error occurred while deleting this group."
          render 'ask_to_destroy'
        end
      else
        flash.now[:danger] = "You're not the proprietary of this group, you can't delete it."
        render 'ask_to_destroy'
      end
    else
      render_404
    end
  end

  def kick
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if @group
      if @group.is_proprietary(current_logged_user)
        group_member = GroupMember.find_by(id: params[:id_member])
        if group_member
          if group_member.user != current_logged_user && !@group.is_proprietary(group_member.user)
            if group_member.destroy
              flash[:success] = group_member.user.name.capitalize+" has been kicked !"
              redirect_to users_group_path(@group.id)
            else
              render 'show'
            end
          else
            flash.now[:danger] = "You can't kick yourself or the group admin."
            render 'show'
          end
        else
          flash.now[:danger] = "Group member not found."
          render 'show'
        end
      else
        flash.now[:danger] = "You're not the proprietary of this group, you can't kick members."
        render 'show'
      end
    else
      render_404
    end
  end

  def must_be_group_proprietary
    group = ( params.has_key?(:users_group) && UsersGroup.find_by(id: users_group_params[:id])) || UsersGroup.find_by(id: params[:users_group_id]) || UsersGroup.find_by(id: params[:id])
    if group
      if !current_logged_user || !group.is_proprietary(current_logged_user)
        render_403
      end
    else
      render_404
    end
  end

  def users_group_params
    params.require(:users_group).permit(:name, :tag, :password, :user_id)
  end

end
