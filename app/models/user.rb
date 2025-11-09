class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  before_create :generate_jti

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end
