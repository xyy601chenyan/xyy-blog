class Article < ApplicationRecord

  validates :title, presence: {message: "请填写文章标题"}
  validates :description, presence: {message: "请填写正文内容"}

  STATUS = ["draft","public","private"]
  validates_inclusion_of :status, :in => STATUS
end
