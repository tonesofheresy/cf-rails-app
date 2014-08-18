class AdminUser < ActiveRecord::Base
	before_save { email.downcase! }
	before_create :generate_remember_token
	
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :name, presence: true
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

	def AdminUser.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def AdminUser.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

	def generate_remember_token
		self.remember_token = AdminUser.digest(AdminUser.new_remember_token)
	end

end
