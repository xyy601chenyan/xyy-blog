class Admin::ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index,:show]
  before_action :require_is_admin


  def index
    @articles = Article.all
  end

  def new
    @article = Article.new

  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "已保存文章"
      redirect_to admin_articles_path
    else
      render :new
  end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "已更新文章"
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:alert] = "已删除文章"
    redirect_to admin_articles_path

  end

  private

  def article_params
    params.require(:article).permit(:title,:description)
  end

end
