class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      # On affiche l'article
      flash[:notice] = "Article bel et bien crée"
      redirect_to article_path(@article)
    else
      # ça n'a pas marcher
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
