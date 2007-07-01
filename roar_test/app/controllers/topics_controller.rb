class TopicsController < ApplicationController
  roar :parent=>:forum do
    include "forum"
    
    table do
      edit :title
      column "forum.name", :name=>"Forum"
      has_many :posts
      has_many :monitorships, :inline=>true
    end
    
    form do
      text_field :title
    end
  end
end
