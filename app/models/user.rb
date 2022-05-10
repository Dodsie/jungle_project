class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, :password_confirmation, presence: true
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if (user && user.authenticate(password))
      user
    else
      nil
    end
  end
end
