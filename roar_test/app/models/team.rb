class Team < ActiveRecord::Base
  belongs_to :league
  belongs_to :division
  
  def self.to_select(division_id)
    Team.find(:all, :conditions => { :division_id => division_id}).map {|l| [l.name,l.id]}
  end
end
