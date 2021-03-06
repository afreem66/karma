class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true

  validates :password,  length: {
    minimum: 8
  }
  has_many :opportunities
end
