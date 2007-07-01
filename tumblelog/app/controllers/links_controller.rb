class LinksController < ApplicationController
  roar :prefix => "admin" do
    order "created_at DESC"
    include :taggings
    
    filters do
      search 'search', :fields => [:title, :body, :metadata]
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
      text_field :link
      text_area :body, :name => "Description"
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
      text_field :link
      text_field :body, :name => "Description"
      text_field :tag_list
    end
  end
end
