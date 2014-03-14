class User < ActiveRecord::Base
  attr_accessible :username, :email, :auth_token, :activated, :session_token, :admin, :password_digest, :password, :uid, :provider, :mobile
  attr_reader :password

  before_validation :ensure_session_token
  before_validation(:ensure_auth_token, on: :create)

  validates :username, :email, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, :allow_nil => true }
  validates :password_digest, presence: true

  has_many :posts,
  dependent: :destroy

  def self.find_uid_or_create(auth)

    user = User.find_by_uid(auth[:uid])

    unless user
      if auth[:provider] == 'facebook'
        user = User.create!(
                 uid: auth[:uid],
                 provider: auth[:provider],
                 username: (auth[:info][:nickname] || auth[:info][:first_name]+rand(1..1000).to_s),
                 email: auth[:info][:email],
                 password: SecureRandom::urlsafe_base64(16)
               )
      elsif auth[:provider] == 'twitter'
        user = User.create!(
                 uid: auth[:uid],
                 provider: auth[:provider],
                 username: auth[:info][:nickname],
                 email: "fillmein@right.meow",
                 password: SecureRandom::urlsafe_base64(16)
               )
      else
        #asdf
      end
    end

    return user
  end


  def self.find_by_credentials(username, password)
    user = (User.find_by_username(username) || User.find_by_email(username))
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def activate!
    self.activated = true
    self.save
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def ensure_auth_token
    self.auth_token ||= self.class.generate_session_token
  end

end
