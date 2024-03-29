require File.dirname(__FILE__) + '/../../spec_helper'
require 'controller_spec_controller'

['integration', 'isolation'].each do |mode|
  describe "A controller example running in #{mode} mode", :behaviour_type => :controller do
    controller_name :controller_spec
    integrate_views if mode == 'integration'
  
    it "should provide controller.session as session" do
      get 'action_with_template'
      session.should equal(controller.session)
    end
  
    it "should provide the same session object before and after the action" do
      session_before = session
      get 'action_with_template'
      session.should equal(session_before)
    end
  
    it "should ensure controller.session is NOT nil before the action" do
      controller.session.should_not be_nil
      get 'action_with_template'
    end
    
    it "should ensure controller.session is NOT nil after the action" do
      get 'action_with_template'
      controller.session.should_not be_nil
    end
    
    it "should allow specifying a partial with partial name only" do
      get 'action_with_partial'
      response.should render_template("_partial")
    end
    
    it "should allow specifying a partial with expect_render" do
      controller.expect_render(:partial => "controller_spec/partial")
      get 'action_with_partial'
    end
    
    it "should allow specifying a partial with expect_render with object" do
      controller.expect_render(:partial => "controller_spec/partial", :object => "something")
      get 'action_with_partial_with_object', :thing => "something"
    end
    
    it "should allow specifying a partial with expect_render with locals" do
      controller.expect_render(:partial => "controller_spec/partial", :locals => {:thing => "something"})
      get 'action_with_partial_with_locals', :thing => "something"
    end
    
    it "should allow a path relative to RAILS_ROOT/app/views/ when specifying a partial" do
      get 'action_with_partial'
      response.should render_template("controller_spec/_partial")
    end
    
    it "should provide access to flash" do
      get 'action_with_template'
      flash[:flash_key].should == "flash value"
    end
    
    it "should provide access to flash values set after a session reset" do
      get 'action_setting_flash_after_session_reset'
      flash[:after_reset].should == "available"
    end
    
    it "should not provide access to flash values set before a session reset" do
      get 'action_setting_flash_before_session_reset'
      flash[:before_reset].should_not == "available"
    end

    it "should provide access to session" do
      get 'action_with_template'
      session[:session_key].should == "session value"
    end

    it "should support custom routes" do
      route_for(:controller => "custom_route_spec", :action => "custom_route").should == "/custom_route_spec/custom_route"
    end

    it "should support existing routes" do
      route_for(:controller => "controller_spec", :action => "some_action").should == "/controller_spec/some_action"
    end

    it "should generate params for custom routes" do
      pending "someone who knows how the routes are gnerated for the specs can work out why this fails" do
        params_from(:get, '/custom_route_spec/custom_route').should == {:controller => "custom_route_spec", :action => "custom_route"}
      end
    end
    
    it "should generate params for existing routes" do
      params_from(:get, '/controller_spec/some_action').should == {:controller => "controller_spec", :action => "some_action"}
    end
    
    it "should expose the assigns hash directly" do
      get 'action_setting_the_assigns_hash'
      assigns[:direct_assigns_key].should == :direct_assigns_key_value
    end
    
    it "should complain when calling should_receive(:render) on the controller" do
      lambda {
        controller.should_receive(:render)
      }.should raise_error(RuntimeError, /should_receive\(:render\) has been disabled/)
    end

    it "should complain when calling stub!(:render) on the controller" do
      lambda {
        controller.stub!(:render)
      }.should raise_error(RuntimeError, /stub!\(:render\) has been disabled/)
    end
    
    it "should NOT complain when calling should_receive with arguments other than :render" do
      controller.should_receive(:anything_besides_render)
      lambda {
        controller.rspec_verify
      }.should raise_error(Exception, /expected :anything_besides_render/)
    end
  end

  describe "Given a controller spec for RedirectSpecController running in #{mode} mode", :behaviour_type => :controller do
    controller_name :redirect_spec
    integrate_views if mode == 'integration'

    it "a redirect should ignore the absence of a template" do
      get 'action_with_redirect_to_somewhere'
      response.should be_redirect
      response.redirect_url.should == "http://test.host/redirect_spec/somewhere"
      response.should redirect_to("http://test.host/redirect_spec/somewhere")
    end
    
    it "a call to response.should redirect_to should fail if no redirect" do
      get 'action_with_no_redirect'
      lambda {
        response.redirect?.should be_true
      }.should fail
      lambda {
        response.should redirect_to("http://test.host/redirect_spec/somewhere")
      }.should fail_with("expected redirect to \"http://test.host/redirect_spec/somewhere\", got no redirect")
    end
  end
  
  describe "Given a controller spec running in #{mode} mode", :behaviour_type => :controller do
    integrate_views if mode == 'integration'
    it "a spec in a context without controller_name set should fail with a useful warning",
      :should_raise => [
        Spec::Expectations::ExpectationNotMetError,
        /You have to declare the controller name in controller specs/
      ] do
    end
  end
  
end

describe ControllerSpecController, :behaviour_type => :controller do
  it "should not require naming the controller if describe is passed a type" do
  end
end

module Spec
  module Rails
    module DSL
      describe ControllerBehaviour do
        it "should tell you its behaviour_type is :controller" do
          behaviour = Class.new(ControllerBehaviour).describe("")
          behaviour.behaviour_type.should == :controller
        end
      end
    end
  end
end
