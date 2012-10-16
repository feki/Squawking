class Answer < ActiveRecord::Base
  attr_accessible :content, :question

  validates :user_id, :presence => true
  validates :content, :presence => true
  validates :question_id, :presence => true

  belongs_to :user
  belongs_to :question
  has_many   :comments, :as => :commentable, :dependent => :destroy
end
