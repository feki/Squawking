class Article < ActiveRecord::Base
  attr_accessible :content

  validates :user_id, :presence => true
  validates :content, :presence => true

  belongs_to :user
  has_many   :reactions, :dependent => :destroy
end
