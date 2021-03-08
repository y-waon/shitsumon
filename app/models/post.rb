class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments
  with_options presence: true do
    validates :title
    validates :text
    validates :image
  end
end
