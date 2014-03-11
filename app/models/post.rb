class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id

  validates :title, :body, :user_id, presence: true
  validates :title, :body, length: { minimum: 3 }

  belongs_to :user

end
