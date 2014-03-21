class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_create :create_remember_token

	has_many :news
	has_many :forum_layouts, dependent: :destroy
	has_many :comments
	has_many :topics
	has_many :posts
	has_many :last_readed_posts, dependent: :destroy

	has_secure_password
	validates :password, length: { minimum: 6}, on: :create

	VALID_USERNAME = /\A[\w\dęóąśłżźćń]+( ?[\w\dęóąśłżźćń]+)*\z/i

	validates :username, presence: true, length: { maximum: 25 },format: { with: VALID_USERNAME }, uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def to_param
    "#{username}"
  end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end

end
