class Article < ApplicationRecord

  validates :title, presence: {message: "请填写文章标题"}
  validates :description, presence: {message: "请填写正文内容"}
end
