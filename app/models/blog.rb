class Blog < ActiveRecord::Base
  belongs_to :user, inverse_of: :blogs

  validates :user, presence: true
end
