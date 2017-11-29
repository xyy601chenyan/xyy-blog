class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :content , presence: {message: "评论内容不能为空"}
end
