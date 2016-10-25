class SessionsController < ApplicationController
    def new
        if !is_logged_in
            render 'new', layout: "login"
        else
            redirect_to user_path(current_logged_user.id)
        end
    end

    def create
        user = User.find_by(mail: params[:session][:mail].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in_session(user)
            redirect_to user_path(user.id)
        else
            flash[:danger] = 'Invalid email or password'
            redirect_to login_path
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end
