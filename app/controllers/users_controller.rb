class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %(edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user?, only: %(destroy)

  def index
    @users = User.page(params[:page]).per(Settings.user.show.per_page).order :created_at
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @posts = @user.posts.page(params[:page]).per(Settings.user.show.per_page)
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t ".notice"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find_by id: params[:id]
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t ".danger"
      redirect_to root_url
    end

    def user_params
      params.require(:user).permit :name, :email, :password,
       :password_confirmation
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = t ".danger"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to root_url unless current_user? @user
    end

    def admin_user?
      redirect_to root_url unless current_user.admin?
    end
end
