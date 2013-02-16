class Project < ActiveRecord::Base
  attr_accessible :description, :name, :tag_list

  # alias for acts_on_taggable_on :tags, question can be tagged
  acts_as_taggable

  validates :name,        presence: true
  validates :description, presence: true

  has_many :articles,  dependent: :destroy
  has_many :questions, dependent: :destroy 
end
