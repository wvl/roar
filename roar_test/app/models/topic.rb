class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts

  has_many :monitorships
  has_many :monitors, :through => :monitorships, :conditions => ['monitorships.active = ?', true], :source => :user, :order => 'users.login'

end
