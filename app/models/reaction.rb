class Reaction < ActiveRecord::Base
  attr_accessible :content

  validates :user_id, :presence => true
  validates :content, :presence => true

  belongs_to :user
  has_many   :comments, :as => :commentable, :dependent => :destroy
end
