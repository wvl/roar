require File.dirname(__FILE__) + '/../spec_helper'

context "Given no news, the NewsItemsController" do
  controller_name :news
    
  specify "should respond to index" do
    controller.should_render :action => "/../../vendor/plugins/roar/views/default/index", :layout=>"roar"
    NewsItem.should_receive(:find)
    get :index
  end  
end