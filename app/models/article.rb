class Article < ActiveRecord::Base
  attr_accessible :content, :title, :project

  validates :user_id, presence: true
  validates :content, presence: true
  validates :title,   presence: true
  validates :project, presence: true

  belongs_to :user
  belongs_to :project
  has_many   :reactions, dependent: :destroy
end
