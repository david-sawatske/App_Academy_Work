class Sub < ApplicationRecord
  validates :description, :title, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :moderator,
    class_name: :User

  has_many :posts, dependent: :destroy, inverse_of: :sub

  has_many :post_subs
end
