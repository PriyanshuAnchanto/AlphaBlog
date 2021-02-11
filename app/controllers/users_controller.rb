class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show
        
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def index 
        @users = User.paginate(page: params[:page], per_page: 6)
    end

    def edit
    end

    def update
        @user.update(set_params)
        if @user.save
            flash[:notice] = "Edit Successfull"
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(set_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "SignUp Successfull!"
            redirect_to @user
        else
          render 'edit'
        end
    end

    def destroy
        session[:user_id] = nil
        @user.destroy
        flash[:notice] = "Account deleted Successfully!"
        redirect_to root_path
    end

    private

    def set_params
        params.require(:user).permit(:name,:email,:password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if !current_user.admin? && current_user != @user
            flash[:alert] = "You are not authorised"
            redirect_to @user
        end
    end
end