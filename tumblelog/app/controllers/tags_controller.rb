class TagsController < ApplicationController
  roar :prefix => "admin" do
    table do
      edit :name
      has_many :posts, :inline => true
      has_many :links, :inline => true
    end
    
    form do
      text_field :name
    end
  end
  
  def index
    @tags = Tag.find(:all)
  end

  def show
    @tag = Tag.find_by_name(params[:id])
  end
    
  def load_instance
    @record = @tag = Tag.find_by_name(params[:id])
  end
end
