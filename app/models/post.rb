class Post < ApplicationRecord
  validates :title, :sub_id, :author_id, presence: true

  belongs_to :author,
    class_name: :User

  belongs_to :sub

  has_many :xposts,
    class_name: :PostSub

  has_many :subs,
    through: :xposts,
    source: :sub
    
end
