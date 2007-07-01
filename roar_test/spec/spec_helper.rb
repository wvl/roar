ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails'
#require 'spec/ui/watir_helper'
begin
  require 'safariwatir'
rescue MissingSourceFile
  require 'watir'
end

# Even if you're using RSpec, RSpec on Rails is reusing some of the
# Rails-specific extensions for fixtures and stubbed requests, response
# and other things (via RSpec's inherit mechanism). These extensions are 
# tightly coupled to Test::Unit in Rails, which is why you're seeing it here.
module Spec
  module Rails
    class EvalContext < Test::Unit::TestCase
      self.use_transactional_fixtures = true
      self.use_instantiated_fixtures  = false
      self.fixture_path = RAILS_ROOT + '/spec/fixtures'

      # You can set up your global fixtures here, or you
      # can do it in individual contexts using "fixtures :table_a, table_b".
      #
      #self.global_fixtures = :table_a, :table_b
    end
  end

#   module Runner
#     class Context
#       def before_context_eval #:nodoc:
#         include Spec::Ui::WebappHelper
#       end
#     end
#   end
end

begin
  Watir::Safari
  class Watir::Safari
    def wait_for_ajax
      10.times do
        return unless image(:id, 'rloading').exists?
        sleep 0.2 
      end
      raise "Ajax not completed"
    end
  end

  module Watir::Container::Clickable
    def click_and_wait(b)
      click
      b.wait_for_ajax
    end
  end
rescue NameError
  class Watir::IE
    def wait_for_ajax
      10.times do
        return unless image(:id, 'rloading').exists?
        sleep 0.2 
      end
      raise "Ajax not completed"
    end
  end
  
  class Watir::Element
    def click_and_wait(b)
       click
       b.wait_for_ajax
     end
  end
end