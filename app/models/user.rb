class User < ActiveRecord::Base
  has_many :cities
  has_many :interests, through: :cities

  has_secure_password
  validates_presence_of :username, :email, :password

end
