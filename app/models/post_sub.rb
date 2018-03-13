class PostSub < ApplicationRecord

  validates :sub_id, presence: true

  belongs_to :post

  belongs_to :sub

end
