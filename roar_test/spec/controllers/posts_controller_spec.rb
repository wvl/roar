require File.dirname(__FILE__) + '/../spec_helper'

context "Given no posts, the PostController" do
  controller_name :posts
  
  specify "class should have roar defined" do
    controller.class.methods.should_include("roar")
  end
  
  specify "should respond to index" do
    controller.should_render :template => "posts/index"
    get :index
  end  
end