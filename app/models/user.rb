class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :messages, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :private_messages, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :group_messages, :dependent => :destroy
  has_many :event_comments, :dependent => :destroy
  has_many :business_messages, :dependent => :destroy
  acts_as_voter
  enum role: [:User, :Lead, :Business, :Admin]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
