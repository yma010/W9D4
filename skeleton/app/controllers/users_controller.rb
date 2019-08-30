class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:session_token] = @user.reset_session_token!
            flash[:success] = "Account created successfully"
            redirect_to cats_url
        else
            flash.now[:error] = @user.errors.full_messages
        render :new
        end 
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end