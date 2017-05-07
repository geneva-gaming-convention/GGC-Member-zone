class SteamAccountsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth_callback
  before_action :must_be_logged

  def auth_callback
    begin
      data = request.env['omniauth.auth']
      account_id = data['extra']['raw_info']['steamid']
      game_account = GameAccount.where(account_id: account_id).first_or_initialize
      if game_account.user && game_account.user != current_logged_user
        raise "This game account is already linked to an other GGC user."
      end
      game_account.name = data['info']['nickname']
      game_account.profile_url = data['extra']['raw_info']['profileurl']
      game_account.image = data['extra']['raw_info']['avatarfull']
      game_account.account_id = account_id
      game_account.last_seen = Time.at(data['extra']['raw_info']['lastlogoff']).strftime("%d %B, %Y at %H:%M")
      game_account.user = current_logged_user
      game_account.game_provider = GameProvider.find_by(name: "steam")
      if game_account.save
        flash[:success] = "Your Steam account has sucessfully been linked !"
      else
        flash[:danger] = "Error while Steam authentication process. "+game_account.errors.full_messages.to_sentence+"."
      end
    rescue Exception => e
      flash[:danger] = e.to_s
    rescue
      flash[:danger] = "Error while Steam authentication process."
    end
    redirect_to edit_user_path(current_logged_user.id)
  end

  def new
    redirect_to "/auth/steam"
  end

  def destroy
    steam_account = GameAccount.find(params[:id])
    begin
      steam_account.destroy
      flash[:success] =  "Your Steam account has successfully been deleted !"
    rescue
      flash[:danger] = "Error while Steam authentication process."
    end
    redirect_to edit_user_path(current_logged_user.id)
  end
end
