class Post < ActiveRecord::Base
  belongs_to :blog, inverse_of: :posts
  has_one :user, through: :blog

  validates :blog, presence: true
end
