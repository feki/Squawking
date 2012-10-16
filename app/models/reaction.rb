class Reaction < ActiveRecord::Base
  attr_accessible :content, :article

  validates :user_id,    :presence => true
  validates :content,    :presence => true
  validates :article_id, :presence => true

  belongs_to :user
  belongs_to :article
  has_many   :comments, :as => :commentable, :dependent => :destroy
end
