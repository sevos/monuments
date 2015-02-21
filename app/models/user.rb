class User < ActiveRecord::Base
  has_secure_password
  validates :login, :password, presence: true, on: :create
  validates :login, uniqueness: true

  def admin?
    role == 'admin'
  end
end