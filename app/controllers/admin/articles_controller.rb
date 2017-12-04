class Admin::ArticlesController < ApplicationController
  before_action :validate_search_key, only:[:find]
  before_action :authenticate_user!, except: [:index,:show]
  before_action :require_is_admin
  layout "admin"

  #定义批量编辑和批量删除的方法
  def bulk_update
    total = 0
    Array(params[:ids]).each do |article_id|
      article = Article.find(article_id)

      if params[:commit] == I18n.t(:bulk_update)
        article.status = params[:article_status]
        article.kind = params[:article_kind]
        if article.save
          total += 1
          flash[:notice] = "已修改#{total}笔资料"
        end
      elsif params[:commit] == I18n.t(:bulk_delete)
        article.destroy
        total += 1
        flash[:alert] = "已删除#{total}笔资料"
      end
    end


    redirect_to :back

  end

  #定义将文章设定为"公开"的方法
  def publish
    @article = Article.find(params[:id])
    @article.publish!
    #redirect_to :back
    render "change_status"
  end

  #定义将文章设定为"草稿"的方法
  def sketch
    @article = Article.find(params[:id])
    @article.sketch!
    #redirect_to :back
    render "change_status"
  end

  #定义将文章设定为"私有"的方法
  def exclusive
    @article = Article.find(params[:id])
    @article.exclusive!
    #redirect_to :back
    render "change_status"
  end

  #定义将文章在后台置顶的方法
  def  move_to_top
    @article = Article.find(params[:id])
    @article.move_to_top
    # redirect_to :back
  end

  #定义在管理员后台找出所有kind为ror的文章
  def ror_page1
    @articles = Article.where(:kind => "ror").order("created_at DESC").paginate(:page => params[:page],:per_page=>10)

  end

  #定义在管理员后台找出所有kind为tutorial的文章
  def tutorial_page1
    @articles = Article.where(:kind => "tutorial").order("created_at DESC").paginate(:page => params[:page],:per_page=>10)
  end

  def growth_page1
    @articles = Article.where(:kind => "growth").order("created_at DESC").paginate(:page => params[:page],:per_page=>10)
  end

  def life_page1
    @articles = Article.where(:kind => "life").order("created_at DESC").paginate(:page => params[:page],:per_page=>10)
  end

  def index
     @articles = case params[:order]
   when 'by_created_at'
     Article.includes(:labels).order("created_at DESC").paginate(:page => params[:page],:per_page =>10)
   else
     Article.includes(:labels).order("position ASC").paginate(:page => params[:page],:per_page =>10)
  end
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
  end

  #定义搜索后台文章的方法（可以搜索状态为私密，公开，草稿的文章）
  def find
    if @query_string.present?
      search_result = Article.ransack(@search_criteria).result(:distinct => true)
      @articles = search_result.paginate(:page => params[:page], :per_page => 10)
    end
  end


  protected

  def validate_search_key
    @query_string = params[:s].gsub(/\\|\'|\/|\?/, "") if params[:s].present?
    @search_criteria = search_criteria(@query_string)

  end

  def search_criteria(query_string)
    {:title_or_description_cont => query_string}

  end


  private

  def article_params
    params.require(:article).permit(:title,:description,:status,:kind,:label_ids => [])
  end

end
