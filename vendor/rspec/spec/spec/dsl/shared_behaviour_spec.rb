require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module DSL
    describe Behaviour, ", with :shared => true" do
      before(:each) do
        @formatter = Spec::Mocks::Mock.new("formatter", :null_object => true)
        @behaviour = Class.new(Behaviour).describe("behaviour")
      end

      after(:each) do
        @formatter.rspec_verify
        @behaviour_class = nil
        $shared_behaviours.clear unless $shared_behaviours.nil?
      end

      def make_shared_behaviour(name, opts=nil, &block)
        behaviour = SharedBehaviour.new(name, :shared => true, &block)
        SharedBehaviour.add_shared_behaviour(behaviour)
        behaviour
      end

      def non_shared_behaviour()
        @non_shared_behaviour ||= Class.new(Behaviour).describe("behaviour")
      end

      it "should accept an optional options hash" do
        lambda { Class.new(Behaviour).describe("context") }.should_not raise_error(Exception)
        lambda { Class.new(Behaviour).describe("context", :shared => true) }.should_not raise_error(Exception)
      end

      it "should return all shared behaviours" do
        b1 = make_shared_behaviour("b1", :shared => true) {}
        b2 = make_shared_behaviour("b2", :shared => true) {}

        b1.should_not be(nil)
        b2.should_not be(nil)

        SharedBehaviour.find_shared_behaviour("b1").should equal(b1)
        SharedBehaviour.find_shared_behaviour("b2").should equal(b2)
      end

      it "should be shared when configured as shared" do
        behaviour = make_shared_behaviour("behaviour") {}
        behaviour.should be_shared
      end

      it "should not be shared when not configured as shared" do
        non_shared_behaviour.should_not be_shared
      end

      it "should raise if run when shared" do
        behaviour = make_shared_behaviour("context") {}
        $example_ran = false
        behaviour.it("test") {$example_ran = true}
        lambda { behaviour.run(@formatter) }.should raise_error
        $example_ran.should be_false
      end

      it "should contain examples when shared" do
        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.it("shared example") {}
        shared_behaviour.number_of_examples.should == 1
      end

      it "should complain when adding a second shared behaviour with the same description" do
        describe "shared behaviour", :shared => true do
        end
        lambda do
          describe "shared behaviour", :shared => true do
          end
        end.should raise_error(ArgumentError)
      end

      it "should NOT complain when adding the same shared behaviour instance again" do
        shared_behaviour = Class.new(Behaviour).describe("shared behaviour", :shared => true)
        SharedBehaviour.add_shared_behaviour(shared_behaviour)
        SharedBehaviour.add_shared_behaviour(shared_behaviour)
      end

      it "should NOT complain when adding the same shared behaviour again (i.e. file gets reloaded)" do
        lambda do
          2.times do
            describe "shared behaviour which gets loaded twice", :shared => true do
            end
          end
        end.should_not raise_error(ArgumentError)
      end

      it "should NOT complain when adding the same shared behaviour in same file with different absolute path" do
        shared_behaviour_1 = Class.new(Behaviour).describe("shared behaviour", :shared => true)
        shared_behaviour_2 = Class.new(Behaviour).describe("shared behaviour", :shared => true)

        shared_behaviour_1.description[:spec_path] = "/my/spec/a/../shared.rb"
        shared_behaviour_2.description[:spec_path] = "/my/spec/b/../shared.rb"

        SharedBehaviour.add_shared_behaviour(shared_behaviour_1)
        SharedBehaviour.add_shared_behaviour(shared_behaviour_2)
      end

      it "should complain when adding a different shared behaviour with the same name in a different file with the same basename" do
        shared_behaviour_1 = Class.new(Behaviour).describe("shared behaviour", :shared => true)
        shared_behaviour_2 = Class.new(Behaviour).describe("shared behaviour", :shared => true)

        shared_behaviour_1.description[:spec_path] = "/my/spec/a/shared.rb"
        shared_behaviour_2.description[:spec_path] = "/my/spec/b/shared.rb"

        SharedBehaviour.add_shared_behaviour(shared_behaviour_1)
        lambda do
          SharedBehaviour.add_shared_behaviour(shared_behaviour_2)
        end.should raise_error(ArgumentError, /already exists/)
      end

      it "should add examples to current behaviour when calling it_should_behave_like" do
        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.it("shared example") {}
        shared_behaviour.it("shared example 2") {}

        @behaviour.it("example") {}
        @behaviour.number_of_examples.should == 1
        @behaviour.it_should_behave_like("shared behaviour")
        @behaviour.number_of_examples.should == 3
      end

      it "should run shared examples" do
        shared_example_ran = false
        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.it("shared example") { shared_example_ran = true }

        example_ran = false

        @behaviour.it_should_behave_like("shared behaviour")
        @behaviour.it("example") {example_ran = true}
        @behaviour.run(@formatter)
        example_ran.should be_true
        shared_example_ran.should be_true
      end

      it "should run setup and teardown from shared behaviour" do
        shared_setup_ran = false
        shared_teardown_ran = false
        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.before { shared_setup_ran = true }
        shared_behaviour.after { shared_teardown_ran = true }
        shared_behaviour.it("shared example") { shared_example_ran = true }

        example_ran = false

        @behaviour.it_should_behave_like("shared behaviour")
        @behaviour.it("example") {example_ran = true}
        @behaviour.run(@formatter)
        example_ran.should be_true
        shared_setup_ran.should be_true
        shared_teardown_ran.should be_true
      end

      it "should run before(:all) and after(:all) only once from shared behaviour" do
        shared_before_all_run_count = 0
        shared_after_all_run_count = 0
        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.before(:all) { shared_before_all_run_count += 1}
        shared_behaviour.after(:all) { shared_after_all_run_count += 1}
        shared_behaviour.it("shared example") { shared_example_ran = true }

        example_ran = false

        @behaviour.it_should_behave_like("shared behaviour")
        @behaviour.it("example") {example_ran = true}
        @behaviour.run(@formatter)
        example_ran.should be_true
        shared_before_all_run_count.should == 1
        shared_after_all_run_count.should == 1
      end

      it "should include modules, included into shared behaviour, into current behaviour" do
        @formatter.should_receive(:add_behaviour).with(any_args)
        @formatter.should_receive(:example_finished).twice.with(any_args)

        shared_behaviour = make_shared_behaviour("shared behaviour") {}
        shared_behaviour.it("shared example") { shared_example_ran = true }

        mod1_method_called = false
        mod1 = Module.new do
          define_method :mod1_method do
            mod1_method_called = true
          end
        end

        mod2_method_called = false
        mod2 = Module.new do
          define_method :mod2_method do
            mod2_method_called = true
          end
        end

        shared_behaviour.include mod2

        @behaviour.it_should_behave_like("shared behaviour")
        @behaviour.include mod1

        @behaviour.it("test") do
          mod1_method
          mod2_method
        end
        @behaviour.run(@formatter)
        mod1_method_called.should be_true
        mod2_method_called.should be_true
      end

      it "should make methods defined in the shared behaviour available in consuming behaviour" do
        shared_behaviour = make_shared_behaviour("shared behaviour xyz") do
          def a_shared_helper_method
            "this got defined in a shared behaviour"
          end
        end
        @behaviour.it_should_behave_like("shared behaviour xyz")
        success = false
        @behaviour.it("should access a_shared_helper_method") do
          a_shared_helper_method
          success = true
        end
        @behaviour.run(@formatter)
        success.should be_true
      end

      it "should raise when named shared behaviour can not be found" do
        begin
          @behaviour.it_should_behave_like("non-existent shared behaviour")
          violated
        rescue => e
          e.message.should == "Shared Behaviour 'non-existent shared behaviour' can not be found"
        end
      end
    end
  end
end
