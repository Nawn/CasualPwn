class GuildMember < ApplicationRecord
	has_secure_password :validations => false
	has_many :posts
end
