class NewsItemsController < ApplicationController
  roar do  
    per_page 5
    order "published_at DESC, title"
    
    filters do
      search :text, :fields => [:title,:body]
      recent_dates :created_at
      recent_dates :published_at
    end
      
    table do
      edit :title
      column :body
      date :published_at, :format=>:short
      delete
    end
    
    form do
      text_field :title
      text_area :body
      check_box :published, :name=>"Published?"      
    end
  end
end

