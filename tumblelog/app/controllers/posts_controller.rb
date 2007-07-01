class PostsController < ApplicationController
  roar :prefix => "admin" do
    per_page 10
    order "created_at DESC"
    
    filters do
      search 'search', :fields => [:title, :body]
      custom { |query, params|
        query.join("taggings").eq("tag_id", params[:tag_id]) if params[:tag_id]
      }
      recent_dates :created_at
    end
    
    table do
      edit :title
      column :tag_list
    end
    
    form do
      text_field :title
      text_area :body
      has_many :tags, :model => Tag do
        text_field :name
      end
    end
  end
  
  roar :layout => "application", :view => "show" do
    order "created_at DESC"
    
    table {}

    form do
      text_field :title
      text_area :body
      text_field :tag_list
    end
  end
end
