class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    @articles = Article.published
                        .includes(:user, :rich_text_content)
                        .order(created_at: :desc)
                        .page(params[:page])
  end

  def show
    @article = Article.friendly.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end

  private

  def set_article
    @article = Article.friendly.find(params[:ids])
  end

  def article_params
    params.require(:article).permit(:title, :content, :published)
  end

  def ensure_owner
    unless @article.user == current_user
      redirect_to root_path, alert: 'You are not authorized to perform this action'
    end
  end
end
