class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  before_create :generate_jti
  has_many :builds
  has_many :likes
  has_many :notifications, foreign_key: :recipient_id

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Allow Devise to find user by username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:username))
      where(conditions).find_by(username: login)
    else
      where(conditions).first
    end
  end

  # Add this method for JWT authentication
  def self.find_for_jwt_authentication(sub)
    find(sub)
  end

  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end
