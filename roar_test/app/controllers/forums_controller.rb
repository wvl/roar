class ForumsController < ApplicationController  
  roar do
    table do
      edit :name
      has_many :topics
      column "moderators.count", :name=>"Moderators"
    end
    
    form do
      text_field :name
      text_area :description
      has_many :moderatorships do
        auto_complete :user
      end
    end
  end  
end
