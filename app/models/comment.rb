class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, :presence => true
  validates :content, :presence => true
end
