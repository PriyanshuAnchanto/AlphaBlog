class SessionsController < ApplicationController
    def new
        
    end

    def oauth
        auth_hash = request.env['omniauth.auth']
        byebug
        @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
        if @authorization
            @user = @authorization.user
            session[:user_id] = @user.id
            flash.now[:alert] = "Logged in Successsfully"
            redirect_to @user
        else
            @user = User.new(name: auth_hash["info"]["name"], email: auth_hash["info"]["email"], password_digest: "Admin@123")
            @user.authorizations << Authorization.new(provider: auth_hash["provider"], uid: auth_hash["uid"])
            #byebug
            if @user.save
                session[:user_id] = @user.id
                flash.now[:alert] = "Logged in Successsfully"
                redirect_to @user

            else
                flash[:alert] = "Something's Wrong"
                redirect_to root_path
            end
        end
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