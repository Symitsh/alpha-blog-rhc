class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, exept: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article bel et bien crée"
      redirect_to article_path(@article)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article bel et bien modifié"
      redirect_to article_path(@article), status: :see_other
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:success] = "Article supprimé avec succès"
    redirect_to articles_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "Vous ne pouvez pas modifier cet article"
      redirect_to root_path, status: :see_other
    end
  end

end
