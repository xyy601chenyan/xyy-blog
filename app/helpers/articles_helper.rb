module ArticlesHelper

  def render_highlight_content(article,query_string)
    excerpt_cont = excerpt(article.title, query_string, radius: 500)
    highlight(excerpt_cont,query_string)
  end

  
end
