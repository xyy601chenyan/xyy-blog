class ArticlesController < ApplicationController
  before_action :validate_search_key, only:[:search]

   def index
     @articles = Article.where(:status => "public").order("created_at DESC")
     @articles = @articles.paginate(:page => params[:page], :per_page => 10)
   end

   def show
    @article = Article.find(params[:id])

    if @article.status != "public"
      flash[:warning] = "该篇文章已归档"
      redirect_to root_path
    end
   end

  #定义搜索文章的方法(只能搜索到状态为"公开"的文章)
   def search
     if @query_string.present?
       search_result = Article.where(:status => "public").ransack(@search_criteria).result(:distinct => true)
       @articles = search_result.paginate(:page => params[:page], :per_page => 10)
     end
   end


   protected

   def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)

   end

   def search_criteria(query_string)
     {:title_or_description_cont => query_string}

   end

end
