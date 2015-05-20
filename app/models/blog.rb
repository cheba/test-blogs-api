class Blog < ActiveRecord::Base
  belongs_to :user, inverse_of: :blogs
  has_many :posts, inverse_of: :blog, dependent: :destroy

  validates :user, presence: true
end
