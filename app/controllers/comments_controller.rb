class CommentsController < ApplicationController
  before_action :authenticate_user!, only:[:create]

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article)
      flash[:alert] = '留言内容不能为空'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id,:article_id,:content)

  end
end
