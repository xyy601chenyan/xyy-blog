module Admin::ArticlesHelper

  def render_article_status(article)
    if article.status == "public"
      content_tag(:span, "", :class => "fa fa-globe",:style => "color:rgba(0,191,165 ,1)")
    elsif article.status == "draft"
      content_tag(:span,"",:class => "fa fa-pencil-square-o")
    else
      content_tag(:span,"",:class => "fa fa-lock",:style => "color: rgba(255,152,0,1)")
  end
  end

end
