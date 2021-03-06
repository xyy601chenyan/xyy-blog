class Article < ApplicationRecord

  validates :title, presence: {message: "请填写文章标题"}
  validates :description, presence: {message: "请填写正文内容"}

  #设定文章的状态
  STATUS = ["draft","public","private"]
  validates_inclusion_of :status, :in => STATUS

  #设定文章的类别
  KIND = ["ror","tutorial","growth","life"]
  validates_inclusion_of :kind, :in => KIND, :allow_nil => true

  has_many :labelships
  has_many :labels , :through => :labelships

  #建立和评论之间的关系
  has_many :comments

  acts_as_list



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

#为网址加上文字,增加网站的安全性
  def to_param
    "#{self.id}-#{self.title}"
  end

end
