require File.dirname(__FILE__) + '/../spec_helper'

context "The News Items Controller" do
  context_setup do
    @b = Watir::Safari.new rescue  Watir::IE.new 
    NewsItem.find(:all).each { |n| n.destroy }
  end
  
  context_teardown do
    NewsItem.find(:all).each { |n| n.destroy }
  end

  setup do
    @b.goto('http://roartest.host:3001/news_items')
  end

#   specify "should have a blank table to start" do
#     @b.contains_text("No Results").should_not_be nil
#   end
  
  specify "should open new form and cancel" do
    @b.link(:text, "New News Item").click
    @b.link(:text, "Cancel").click
    @b.contains_text("Published?").should_be nil
  end
  
  specify "should create new news" do
    @b.link(:text, "New News Item").click
    @b.text_field(:name, "news_item[title]").set("better than sliced bread")
    @b.button(:value, "Save").click_and_wait(@b)
    @b.contains_text("better than sliced bread").should_not_be nil
    NewsItem.find_by_title("better than sliced bread").should_not_be nil
  end
  
  specify "should open edit form for news item" do
    @b.link(:text, "better than sliced bread").click
    @b.contains_text("Edit News").should_not_be nil
    @b.text_field(:name, "news_item[body]").set("roar, of course.")
    @b.button(:value, "Save").click_and_wait(@b)
    @b.contains_text("roar, of course.").should_not_be_nil
    NewsItem.find_by_title("better than sliced bread").body.should == "roar, of course."
  end
  
  specify "should be able to delete news item" do
    @b.link(:text, "Delete").click
    @b.contains_text("Delete better than sliced bread").should_not_be nil
    @b.button(:name, "delete").click
    @b.wait_for_ajax
    @b.contains_text("better than sliced bread").should_be nil
  end

#   teardown do
#     save_screenshot_and_source(@b)
#   end
end
