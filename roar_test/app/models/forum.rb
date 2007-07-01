class Forum < ActiveRecord::Base
  has_many :topics
  has_many :moderatorships
  has_many :moderators, :through => :moderatorships, :source => :user, :order => 'users.login'
  
  attr_writer :new_moderatorships, :edit_moderatorships
  after_save :update_moderators
  
  def update_moderators
    moderatorships.each {|mod| mod.destroy if !(@edit_moderatorships || {}).has_key?(mod.id.to_s) }
    (@new_moderatorships || []).each { |params| 
      moderators << User.find(params[:user_id]) unless params[:user_id].empty?
    }
  end
end
