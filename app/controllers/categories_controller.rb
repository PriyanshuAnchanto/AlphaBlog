class CategoriesController < ApplicationController
    before_action :find_category, only: [:show, :edit, :update]
    before_action :is_admin? , except: [:show,:index]
    def new
        @category = Category.new
    end


    def index
        @categories = Category.paginate(page: params[:page], per_page: 6)
    end

    def show
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def create
        @category = Category.new(set_params)
        if @category.save
            flash[:notice] = "Category added Successfully!"
            redirect_to @category
        else
            render 'new'
        end
    end

    def update
        @category.update(set_params)
        if @category.save
            flash[:notice] = "Category edited Successfully!"
            redirect_to @category
        else
            render 'new'
        end
    end

    private
    def find_category 
        @category = Category.find(params[:id])
    end

    def set_params
        params.require(:category).permit(:name)
    end

    def is_admin?
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "Only Admins are allowed!!"
            redirect_to categories_path
        end
    end
end