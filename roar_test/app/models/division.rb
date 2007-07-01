class Division < ActiveRecord::Base
  belongs_to :league
  has_many :games
  has_many :teams

  def self.to_select(league_id=nil)
    Division.find(:all, :conditions=>{:league_id=>league_id}).map {|l| [l.name,l.id]}
  end

end
