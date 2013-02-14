class Question < ActiveRecord::Base
  attr_accessible :content, :title, :project, :tag_list

  # alias for acts_on_taggable_on :tags, question can be tagged
  acts_as_taggable

  validates :content, presence: true
  validates :title,   presence: true
  validates :user_id, presence: true
  validates :project, presence: true

  belongs_to :user
  belongs_to :project
  has_many   :answers, dependent: :destroy
end
