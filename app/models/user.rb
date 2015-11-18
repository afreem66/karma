class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true
  validates :password_digest, presence: true

  validates :pasword,  length: {
    minimum: 8
  }
end
