class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username], 
            params[:user][:password]
            )
        if user 
            session[:session_token] = user.reset_session_token!
            flash[:success] = ["Logged in!"]
            redirect_to cats_url
        else
            flash.now[:error] = ["Invalid credentials"]
            render :new, status: 401
        end
    end

    def destroy
        current_user.reset_session_token! if current_user
        session[:session_token] = nil
        flash[:success] = ["Logged Out, see you crazy cat lady!"]
        redirect_to cats_url
    end
end