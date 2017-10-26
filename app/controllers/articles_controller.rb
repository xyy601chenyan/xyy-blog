class ArticlesController < ApplicationController
  before_action :validate_search_key, only:[:search]

   def index
     @articles = Article.all.order("created_at DESC")
   end

   def show
    @article = Article.find(params[:id])
   end


   def search
     if @query_string.present?
       search_result = Article.ransack(@search_criteria).result(:distinct => true)
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
