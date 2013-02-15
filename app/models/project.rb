class Project < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name,        presence: true
  validates :description, presence: true

  has_many :articles,  dependent: :destroy
  has_many :questions, dependent: :destroy 
  has_and_belongs_to_many :users
end
