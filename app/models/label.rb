class Label < ApplicationRecord
  has_many :lableships
  has_many :articles, :through => :labelships
end
