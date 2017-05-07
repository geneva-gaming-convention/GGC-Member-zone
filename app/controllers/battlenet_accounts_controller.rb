class BattlenetAccountsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth_callback
  before_action :must_be_logged
  before_action :must_be_proprietary, only: [:destroy]


  def auth_callback
    begin
      data = request.env['omniauth.auth']
      account_id = data['info']['id']
      game_account = GameAccount.where(account_id: account_id).first_or_initialize
      if game_account.user && game_account.user != current_logged_user
        raise "This game account is already linked to an other GGC user."
      end
      game_account.name = data['info']['battletag']
      game_account.account_id = account_id
      game_account.user = current_logged_user
      game_account.game_provider = GameProvider.find_by(name: "battlenet")
      if game_account.save
        flash[:success] = "Your Battle.net account has sucessfully been linked !"
      else
        flash[:danger] = "Error while Battle.net authentication process. "+game_account.errors.full_messages.to_sentence+"."
      end
    rescue Exception => e
      flash[:danger] = e.to_s
    rescue
      flash[:danger] = "Error while Battle.net authentication process."
    end
    redirect_to edit_user_path(current_logged_user.id)
  end

  def new
    redirect_to "/auth/bnet"
  end

  def destroy
    bnet_account = GameAccount.find(params[:id])
    begin
      bnet_account.destroy
      flash[:success] =  "Your Steam account has successfully been deleted !"
    rescue
      flash[:danger] = "Error while steam authentication process."
    end
    redirect_to edit_user_path(current_logged_user.id)
  end
end
