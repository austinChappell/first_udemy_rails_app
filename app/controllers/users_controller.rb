class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User successfully created"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to user_path
    else
      render :edit
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    if @user == current_user
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path
      flash[:success] = "You have successfully deleted your account"
    elsif logged_in? && current_user.admin?
      @user.destroy
      redirect_to users_path
      flash[:success] = "You have successfully deleted this user"
    else
      redirect_to users_path
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to users_path
      flash[:danger] = "You must be the logged in user to update this user"
    end
  end
end
