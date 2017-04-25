class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :author,
    class_name: :user

end
