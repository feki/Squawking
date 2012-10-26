class Question < ActiveRecord::Base
  attr_accessible :content, :project

  validates :content, presence: true
  validates :user_id, presence: true
  validates :project, presence: true

  belongs_to :user
  belongs_to :project
  has_many   :answers, dependent: :destroy
end
