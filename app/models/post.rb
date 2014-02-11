class Post < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :body, presence: true
  validates :title, :body, length: { minimum: 3 }

end
