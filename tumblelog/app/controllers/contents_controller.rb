class ContentsController < ApplicationController  
  roar :layout => "application", :view => "show" do
    per_page 10
    order "created_at DESC"

    table {}

    form do
      text_field :title
      text_area :body
      text_field :tag_list
    end
  end
end