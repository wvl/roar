module Spec
  module Story
    class Story
      attr_reader :title, :narrative
      
      def initialize(title, narrative, params = {}, &body)
        raise(ArgumentError, 'A story needs a body') unless block_given?
        @body = body
        @title = title
        @narrative = narrative
        @params = params
      end
      
      def [](key)
        @params[key]
      end
      
      def run_in(obj)
        obj.instance_eval(&@body)
      end
    end
  end
end
