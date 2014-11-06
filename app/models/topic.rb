class Topic < ActiveRecord::Base

  # has_friendly_id :name, :use_slug => true

  attr_accessible :description, :name, :public, :topic
  has_many :posts, dependent: :destroy
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
