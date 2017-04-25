class Post < ApplicationRecord
  validates :content, :title, :author, :sub, presence: true
  validates :title, uniqueness: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :author,
    class_name: :User

  belongs_to :sub
end
