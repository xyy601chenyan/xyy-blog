class Article < ApplicationRecord

  validates :title, presence: {message: "请填写文章标题"}
  validates :description, presence: {message: "请填写正文内容"}

  STATUS = ["draft","public","private"]
  validates_inclusion_of :status, :in => STATUS


#定义方法，将文章的类型修改为"public"(公开)
  def publish!
    self.status = "public"
    self.save
  end

#定义方法，将文章的类型修改为"draft"(草稿)
  def sketch!
    self.status = "draft"
    self.save
  end

#定义方法,将文章的类型修改为"pravite"(私密)
  def exclusive!
    self.status = "private"
    self.save
  end
end
