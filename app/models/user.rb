class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :project_ids
  # attr_accessible :title, :body

  has_many :comments,  :dependent => :destroy
  has_many :answers,   :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :reactions, :dependent => :destroy
  has_many :articles,  :dependent => :destroy
  has_and_belongs_to_many :projects

  email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => { :with => email_regexp }
end
