require File.dirname(__FILE__) + '/../spec_helper'

context "The League Controller" do
  context_setup do
    @b = Watir::Safari.new rescue  Watir::IE.new 
    League.find(:all).each { |n| n.destroy }
    Division.find(:all).each { |n| n.destroy }
  end
  
  context_teardown do
    League.find(:all).each { |n| n.destroy }
    Division.find(:all).each { |n| n.destroy }
  end

  setup do
    @url = 'http://roartest.host:3001/leagues'
    @b.goto(@url)
  end

#   specify "should have a blank table to start" do
#     @b.contains_text("No Results").should_not_be nil
#   end
    
  specify "should create new league" do
    @b.link(:text, "New League").click
    @b.text_field(:name, "league[name]").set("Summer League")
    @b.button(:value, "Save").click_and_wait(@b)
    @b.contains_text("Summer League").should_not_be nil
    League.find_by_name("Summer League").should_not_be nil
  end

  specify "should add divisions" do
    @b.link(:text, /Divisions/).click_and_wait(@b)
    @b.contains_text("New Division").should_not_be nil
    @b.link(:text, "New Division").click_and_wait(@b)
    @b.text_field(:name, "division[name]").set("Elite")
    @b.button(:value, "Save").click_and_wait(@b)
    @b.contains_text("Elite").should_not_be nil
    League.find(:first).divisions.first.name.should == "Elite"
  end

  specify "should edit divisions" do
    @b.link(:text, /Division/).click_and_wait(@b)
    @b.link(:url, /divisions\/\d*;edit/).click_and_wait(@b)
    @b.text_field(:name, "division[name]").set("Elite 1")
    @b.button(:value, "Save").click_and_wait(@b)
    League.find(:first).divisions.first.name.should == "Elite 1"
  end

  specify "should delete divisions" do
    @b.link(:text, /Division/).click_and_wait(@b)
    @b.link(:url, /divisions\/\d*;delete/).click_and_wait(@b)
    @b.contains_text("Delete Elite 1?").should_not_be nil
    @b.button(:value, "Yes, Delete").click_and_wait(@b)
    @b.goto(@url)
    @b.contains_text("Elite").should_be nil
  end
    
  specify "should edit league" do
    @b.link(:text, "Summer League").click_and_wait(@b)
    @b.contains_text("Edit League").should_not_be nil
    @b.select_list(:name, "league[year(1i)]").select_value("2008")
    @b.button(:value, "Save").click_and_wait(@b)
    @b.contains_text("Summer League").should_not_be nil
    League.find_by_name("Summer League").year.year.should == 2008
  end
  
  specify "should switch seasons inline" do
    @b.link(:text, "summer").click_and_wait(@b)
    @b.select_list(:name, "league[season]").select("Winter")
    @b.button(:value, "Submit").click_and_wait(@b)
    @b.contains_text("winter").should_not_be nil
    League.find_by_name("Summer League").season.should == "winter"
  end

#   teardown do
#     save_screenshot_and_source(@b)
#   end
end
