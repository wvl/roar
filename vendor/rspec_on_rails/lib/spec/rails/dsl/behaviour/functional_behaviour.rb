module Spec
  module Rails
    module DSL
      class FunctionalBehaviour < RailsBehaviour
        include ActionController::TestProcess
        include ActionController::Assertions

        attr_reader :request, :response
        def functional_setup #:nodoc:
          @test_case.setup
          @controller_class = Object.path2class @controller_class_name
          raise "Can't determine controller class for #{@controller_class_name}" if @controller_class.nil?

          @controller = @controller_class.new

          @request = ActionController::TestRequest.new
          @response = ActionController::TestResponse.new
        end

        def params
          request.parameters
        end

        def flash
          response.flash
        end

        def session
          request.session
        end

        # :call-seq:
        #   assigns()
        #
        # Hash of instance variables to values that are made available to views.
        # == Examples
        #
        #   #in thing_controller.rb
        #   def new
        #     @thing = Thing.new
        #   end
        #
        #   #in thing_controller_spec
        #   get 'new'
        #   assigns[:registration].should == Thing.new
        #--
        # NOTE - Even though docs say only use assigns[:key] format, but allowing assigns(:key)
        # in order to avoid breaking old specs.
        #++
        def assigns(key = nil)
          if key.nil?
            @controller.assigns
            _controller_ivar_proxy
          else
            @controller.assigns[key]
            _controller_ivar_proxy[key]
          end
        end

        protected
        def _controller_ivar_proxy
          @controller_ivar_proxy ||= IvarProxy.new @controller
        end
      end
    end
  end
end
