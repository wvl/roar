class Tag < ActiveRecord::Base
  has_many_polymorphs :taggables, :from => [:posts, :links], :through => :taggings, :dependent => :destroy
  
  def to_param
    name
  end
end
