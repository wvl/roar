require File.dirname(__FILE__) + '/../spec_helper'

context "A post" do
  specify "should be sane" do
    Post.new(:body=>"Hello there world.").should_be_valid
  end
end
