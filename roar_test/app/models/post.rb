class Post < ActiveRecord::Base
  belongs_to :forum
  belongs_to :topic
  before_create { |r| r.forum_id = r.topic.forum_id }
  
end
