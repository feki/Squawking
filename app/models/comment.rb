class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :user_id, :presence => true
  validates :commentable, :presence => true
  validates :content, :presence => true
end
