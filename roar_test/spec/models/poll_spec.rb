require File.dirname(__FILE__) + '/../spec_helper'

context "A poll with no options" do
  specify "should be valid" do
    Poll.new(:description=>"Test Poll").should be_valid
  end
  
  specify "should create an option" do
    poll = Poll.create(:description=>"Test", :new_poll_options=>[{:option=>'opt1'}])
    poll.should be_valid
    poll.poll_options.size.should == 1
  end
  
  specify "should not create an option if the text is blank" do
    poll = Poll.create(:description=>"Test", :new_poll_options=>[{:option=>''}])
    poll.should be_valid
    poll.poll_options.size.should == 0
  end
end

context "A poll with 2 options" do
  setup do
    @poll = Poll.create(:description => "Test Poll")
    @poll.poll_options << PollOption.create(:option=>"one")
    @poll.poll_options << PollOption.create(:option=>"two")
  end
  
  specify "should have two options" do
    @poll.poll_options.size.should == 2
  end
end
    
