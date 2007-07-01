class NewsItem < ActiveRecord::Base
  validates_presence_of :title
  
  def published
    !published_at.nil?
  end
  
  def published=(value)
    self.published_at = value=="0" ? nil : Time.now
  end
  
end 
