class User < ActiveRecord::Base
	before_save { email.downcase! }

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :first, presence: { message: "name can't be empty" }
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

end
