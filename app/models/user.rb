class User < ApplicationRecord

  validates :user_name, presence: true
  # validates :email, uniqueness: true, presence: true

  has_secure_password 

  def self.create_from_omniauth(auth)
    User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u| 
      u.email = auth['info']['email']
      u.name = auth['info']['name']
      u.password = SecureRandom.hex(16)
    end
  end
end