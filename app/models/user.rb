class User < ApplicationRecord
	# downcase email entries before save to double-ensure uniqueness, same as {self.email = email.downcase}
	before_save { email.downcase! }
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, 
		format: {with: VALID_EMAIL_REGEX}, uniqueness: true
	has_secure_password #works with 'bcrypt gem'
	validates :password, presence: true, length: { minimum: 6 }
end
