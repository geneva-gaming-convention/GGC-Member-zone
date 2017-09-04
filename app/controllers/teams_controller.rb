class TeamsController < ApplicationController
  before_action :must_be_logged,                            only:   [:new, :create, :list, :kick]
  before_action :user_must_be_in_users_group,               only:   [:new, :create, :ask_to_destroy, :destroy, :update, :join, :kick]
  before_action :users_group_must_exist,                    except: [:list, :global_list]
  before_action :team_must_exist,                           except: [:new, :create, :list, :global_list]
  before_action :must_be_admin_of_team,                     only:   [:ask_to_destroy, :destroy, :update, :kick]
  before_action :are_some_places_available,                 only:   [:join]

  def new
    @team = Team.new
    @group = UsersGroup.find_by(id: params[:users_group_id])
    @games = []
    Game.all.where(teambased: true).each do |game|
      @games.push([game.name, game.id])
    end
  end

  def create
    @team = Team.new(team_params)
    @games = []
    Game.all.where(teambased: true).each do |game|
      @games.push([game.name, game.id])
    end
    @team.game = Game.find_by(id: team_params[:game_id])
    @team.users_group = UsersGroup.find_by(id: params[:users_group_id])
    if @team.save
      team_member = TeamMember.new
      team_member.user = current_logged_user
      team_member.team = @team
      team_member.is_creator = true
      if team_member.save
        flash[:success] = @team.users_group.tag+" "+@team.name+" successfully created !"
        redirect_to users_group_team_path(@team.users_group, @team)
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @group = UsersGroup.find_by(id: params[:users_group_id])
    @team = Team.find_by(id: params[:id])
  end

  def list
    @user = current_logged_user
    @teams = @user.teams
  end

  def global_list
    @user = current_logged_user
    @teams = Team.all
    render 'list'
  end

  def update
    @group = UsersGroup.find_by(id: params[:users_group_id])
    @team = Team.find_by(id: params[:id])
    @team.update_attributes(team_params)
    if @team.save
      flash[:success] = @team.users_group.tag+" "+@team.name+" has been updated successfully."
      redirect_to users_group_team_path(@group, @team)
    else
      render 'show'
    end
  end

  def ask_to_leave

  end

  def leave
    if @team.is_user_in_team(current_logged_user)
      team_member = TeamMember.find_by(user: current_logged_user, team: @team)
      if team_member.destroy
        flash[:success] = "You left "+@team.users_group.tag+" "+@team.name+" successfully."
        redirect_to users_group_team_path(@group, @team)
      else
        flash.now[:danger] = team_member.errors.full_messages.to_sentence
        render 'ask_to_leave'
      end
    else
      render_403
    end
  end

  def join
    @member = TeamMember.new
    @member.user = current_logged_user
    @member.team = @team
    @member.is_creator = false
    if @member.save
      flash[:success] = "You successfully joined "+@team.users_group.tag+" "+@team.name+"."
      redirect_to users_group_team_path(@group, @team)
    else
      flash.now[:danger] = @member.errors.full_messages.to_sentence
      render 'show'
    end
  end

  def kick
    @team_member = TeamMember.find_by(id: params[:id_member])
    if @team_member
      if @team_member.destroy
        flash[:success] = "You successfully kicked "+@team_member.user.name+"."
        redirect_to users_group_team_path(@group, @team)
      else
        flash.now[:danger] = @member.errors.full_messages.to_sentence
        render 'show'
      end
    else
      render_403
    end
  end

  def ask_to_destroy

  end

  def destroy
    @group = @team.users_group
    if @team.destroy
      flash[:success] = @team.name+" successfully deleted !"
      redirect_to users_group_path(@group)
    else
      flash.now[:danger] = "An error occurred while deleting this team."
      render 'ask_to_destroy'
    end
  end

  def users_group_must_exist
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if !@group
      render_404
    end
  end

  def team_must_exist
    @team = Team.find_by(id: params[:team_id]) || Team.find_by(id: params[:id])
    if !@team
      render_404
    end
  end

  ## Check that the current_logged_user is members of the main users group
  def user_must_be_in_users_group
    @group = UsersGroup.find_by(id: params[:users_group_id])
    if @group
      if !@group.is_user_already_group_member(current_logged_user)
        render_403
      end
    else
      render_404
    end
  end

  def must_be_in_team
    if current_logged_user
    else
      render_403
    end
  end

  def must_be_admin_of_team
    @team = Team.find_by(id: params[:team_id]) || Team.find_by(id: params[:id])
    if @team
      @team.team_members.each do |team_member|
        if team_member.user == current_logged_user
          if !team_member.is_creator
            render_403
          end
        end
      end
    else
      render_404
    end
  end

  def are_some_places_available
    if @team.game.nb_players <= @team.team_members.count
      flash.now[:danger] = "This team is already full."
      render 'show'
    end
  end

  def team_params
    params.require(:team).permit(:name, :tag, :users_group_id, :game_id)
  end

end
