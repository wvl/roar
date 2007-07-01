require File.dirname(__FILE__) + '/../../../spec_helper.rb'

context "should_respond_to" do
  specify "should fail when target doesnt respond to" do
    lambda do
      "".should_respond_to(:connect)
    end.should_fail
  end

  specify "should pass when target responds to" do
    lambda do
      "".should_respond_to(:length)
    end.should_not_raise
  end
end