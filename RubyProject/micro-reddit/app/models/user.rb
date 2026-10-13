class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: 3..20 }
  validates :email, presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
end