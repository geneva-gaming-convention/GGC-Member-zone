class BattlenetAccountsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth_callback

  def auth_callback
    data = request.env['omniauth.auth']
    render json: data
  end

  def new
    redirect_to "/auth/bnet"
  end
end
