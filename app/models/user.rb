class User < ActiveRecord::Base
	before_save { email.downcase! }

	has_secure_password
	validates :password, length: { minimum: 6}

	validates :username, presence: true, length: { maximum: 25 }, uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

end
