class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash.now[:alert] = "Logged in Successsfully"
            redirect_to user
        else
            flash.now[:alert] = "Something's Wrong"
            render 'new'
        end
    end

    def destroy
        session.delete(:user_id)
        @_current_user = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end


end