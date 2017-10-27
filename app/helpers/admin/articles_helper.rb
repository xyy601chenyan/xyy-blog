module Admin::ArticlesHelper

  def render_article_status(article)
    if article.status == "public"
      content_tag(:span, "", :class => "fa fa-globe")
    elsif article.status == "draft"
      content_tag(:span,"",:class => "fa fa-pencil-square-o")
    else
      content_tag(:span,"",:class => "fa fa-lock")
  end
  end

end
