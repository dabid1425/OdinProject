class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true, length: { in: 3..500 }
  validate :parent_on_same_post

  private

  def parent_on_same_post
    if parent && parent.post_id != post_id
      errors.add(:parent, "must be on the same post")
    end
  end
end
