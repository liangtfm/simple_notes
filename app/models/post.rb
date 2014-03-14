class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id

  before_validation :ensure_title
  validates :title, :body, :user_id, presence: true
  validates :title, :body, length: { minimum: 3 }

  belongs_to :user

  def ensure_title
    self.title = self.title || Time.now
  end

end
