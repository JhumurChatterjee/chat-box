class User < ApplicationRecord
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  before_validation { name.to_s.squish! }
  before_validation { email.to_s.squish.downcase! }

  validates :name,  presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }

  scope :other_users, ->(current_user_id) { where.not(id: current_user_id) }
end
