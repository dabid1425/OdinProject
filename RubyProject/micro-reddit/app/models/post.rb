class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { in: 2..100 }
  validates :body, presence: true, length: { in: 3..500 }
end
