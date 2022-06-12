class UsersController < ApplicationController
  before_action :set_user, lonly: [:edit, :update, :show]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Bienvenue sur le blog #{@user.username} !"
      redirect_to articles_path
    else
      render 'new' , status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profil mis à jour"
      redirect_to articles_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 3)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
