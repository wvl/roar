module Spec
  module Rails
    module DSL
      # Helper Specs live in $RAILS_ROOT/spec/helpers/.
      #
      # Helper Specs use Spec::Rails::DSL::HelperBehaviour, which allows you to
      # include your Helper directly in the context and write specs directly
      # against its methods.
      #
      # HelperBehaviour also includes the standard lot of ActionView::Helpers in case your
      # helpers rely on any of those.
      #
      # == Example
      #
      #   class ThingHelper
      #     def number_of_things
      #       Thing.count
      #     end
      #   end
      #
      #   describe "ThingHelper behaviour" do
      #     include ThingHelper
      #     it "should tell you the number of things" do
      #       Thing.should_receive(:count).and_return(37)
      #       number_of_things.should == 37
      #     end
      #   end
      class HelperBehaviour < FunctionalBehaviour
        class << self
          def before_eval #:nodoc:
            super
            prepend_before {helper_setup}
            append_after {@test_case.teardown}
            configure
          end

          # The helper name....
          def helper_name(name=nil)
            send :include, "#{name}_helper".camelize.constantize
          end
        end

        include ActionView::Helpers::ActiveRecordHelper
        include ActionView::Helpers::AssetTagHelper
        include ActionView::Helpers::BenchmarkHelper
        include ActionView::Helpers::CacheHelper
        include ActionView::Helpers::CaptureHelper
        include ActionView::Helpers::DateHelper
        include ActionView::Helpers::DebugHelper
        include ActionView::Helpers::FormHelper
        include ActionView::Helpers::FormOptionsHelper
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::JavaScriptHelper
        include ActionView::Helpers::JavaScriptMacrosHelper
        include ActionView::Helpers::NumberHelper
        include ActionView::Helpers::PaginationHelper rescue nil #removed after 1.2.3
        include ActionView::Helpers::PrototypeHelper
        include ActionView::Helpers::PrototypeHelper::JavaScriptGenerator::GeneratorMethods
        include ActionView::Helpers::RecordIdentificationHelper rescue nil
        include ActionView::Helpers::ScriptaculousHelper
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper
        ActionController::Routing::Routes.named_routes.install(self)

        def helper_setup #:nodoc:
          @controller_class_name = 'Spec::Rails::DSL::HelperBehaviourController'
          functional_setup
          @controller.request = @request
          @controller.url = ActionController::UrlRewriter.new @request, {} # url_for

          @flash = ActionController::Flash::FlashHash.new
          session['flash'] = @flash

          # This is to fix the JavaScriptGenerator::GeneratorMethods issue
          # TODO: Refactor me
          @lines = []

          ActionView::Helpers::AssetTagHelper::reset_javascript_include_default
        end

        def flash
          @flash
        end

        def eval_erb(text)
          ERB.new(text).result(binding)
        end

        Spec::DSL::BehaviourFactory.add_behaviour_class(:helper, self)
      end

      class HelperBehaviourController < ApplicationController #:nodoc:
        attr_accessor :request, :url

        # Re-raise errors
        def rescue_action(e); raise e; end
      end
    end
  end
end
