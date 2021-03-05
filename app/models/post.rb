class Post < ApplicationRecord
  has_one_attached :image
  with_options presence: true do
    validates :title
    validates :text
  end
end
