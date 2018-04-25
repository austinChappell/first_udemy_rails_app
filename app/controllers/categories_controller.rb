class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show]
  before_action :require_admin, only: [:new, :create, :update, :edit]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      flash[:failure] = "Category was not created"
      render :new
    end
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category successfully updated"
      redirect_to category_path
    else
      flash[:failure] = "Category failed to update"
      render :edit
    end
  end

  def show
    
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to categories_path
    end
  end
end