class Sub < ApplicationRecord
  validates :title, :description, :moderator_id, presence: true

  has_many :posts

  belongs_to :moderator,
    class_name: :User

  has_many :post_subs,
    class_name: :PostSub

  has_many :xposts,
    through: :post_subs,
    source: :post
end
