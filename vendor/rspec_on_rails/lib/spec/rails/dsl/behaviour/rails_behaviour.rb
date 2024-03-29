ActionView::Base.cache_template_extensions = false

module Spec
  module Rails
    module DSL
      class RailsBehaviour < Spec::DSL::Behaviour
        class << self
          extend Forwardable
          attr_reader :test_case_class

          def configure
            self.use_transactional_fixtures = Spec::Runner.configuration.use_transactional_fixtures
            self.use_instantiated_fixtures = Spec::Runner.configuration.use_instantiated_fixtures
            self.fixture_path = Spec::Runner.configuration.fixture_path
            self.global_fixtures = Spec::Runner.configuration.global_fixtures
            self.fixtures(self.global_fixtures) if self.global_fixtures
          end

          def_delegators(
            :@test_case_class,
            :use_transactional_fixtures,
            :use_transactional_fixtures=,
            :use_instantiated_fixtures,
            :use_instantiated_fixtures=,
            :fixture_path,
            :fixture_path=,
            :global_path,
            :global_path=,
            :fixtures,
            :global_fixtures,
            :global_fixtures=
          )

          def before_eval #:nodoc:
            super
            @test_case_class = Class.new(Spec::Rails::DSL::RailsTestCase)
            prepend_before {@test_case.setup}
            append_after {@test_case.teardown}
            configure
          end          
        end

        extend Forwardable

        include Spec::Rails::Matchers

        def initialize(behaviour, example) #:nodoc:
          super
          @test_case = test_case_class.new
          def self.method_missing(method_name, *args, &block)
            return ::Spec::Matchers::Be.new(method_name, *args) if method_name.starts_with?("be_")
            return ::Spec::Matchers::Has.new(method_name, *args) if method_name.starts_with?("have_")
            return @test_case.send(method_name, *args, &block) if @test_case.respond_to?(method_name)
            super
          end
        end

        def_delegators  :@rspec_behaviour,
                        :test_case_class

        @@model_id = 1000
        # Creates a mock object instance for a +model_class+ with common
        # methods stubbed out.
        # Additional methods may be easily stubbed (via add_stubs) if +stubs+ is passed.
        def mock_model(model_class, options_and_stubs = {})
          null = options_and_stubs.delete(:null_object)
          stubs = options_and_stubs
          id = @@model_id
          @@model_id += 1
          m = mock("#{model_class.name}_#{id}", :null_object => null)
          m.stub!(:id).and_return(id)
          m.stub!(:to_param).and_return(id.to_s)
          m.stub!(:new_record?).and_return(false)
          m.stub!(:errors).and_return(stub("errors", :count => 0))
          m.send(:__mock_proxy).instance_eval <<-CODE
            def @target.is_a?(other)
              #{model_class}.ancestors.include?(other)
            end
            def @target.kind_of?(other)
              #{model_class}.ancestors.include?(other)
            end
            def @target.instance_of?(other)
              other == #{model_class}
            end
            def @target.class
              #{model_class}
            end
          CODE
          add_stubs(m, stubs)
          yield m if block_given?
          m
        end

        #--
        # TODO - Shouldn't this just be an extension of stub! ??
        # - object.stub!(:method => return_value, :method2 => return_value2, :etc => etc)
        #++
        # Stubs methods on +object+ (if +object+ is a symbol or string a new mock
        # with that name will be created). +stubs+ is a Hash of <tt>method=>value</tt>
        def add_stubs(object, stubs = {}) #:nodoc:
          m = [String, Symbol].index(object.class) ? mock(object.to_s) : object
          stubs.each {|k,v| m.stub!(k).and_return(v)}
          m
        end
        Spec::DSL::BehaviourFactory.add_behaviour_class(:default, self)
      end
    end
  end
end
