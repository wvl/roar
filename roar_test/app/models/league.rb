class League < ActiveRecord::Base
  has_many :divisions
  has_many :games

  def self.to_select
    League.find(:all, :order=>"year DESC").map {|l| [l.name,l.id.to_s]}
  end

end
