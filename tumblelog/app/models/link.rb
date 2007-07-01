class Link < Content
  def link=(url)
    self.metadata ||= {}
    self.metadata[:link] = url
  end
  
  def link
    (self.metadata || {})[:link]
  end
end
