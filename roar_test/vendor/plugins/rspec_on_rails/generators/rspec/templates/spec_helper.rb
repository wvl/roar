# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails'

module Spec
  module Rails
    module Runner
      class EvalContext < Test::Unit::TestCase
        self.use_transactional_fixtures = true
        self.use_instantiated_fixtures  = false
        self.fixture_path = RAILS_ROOT + '/spec/fixtures'

        # You can declare fixtures within each context like this:
        #   context "...." do
        #     fixtures :table_a, :table_b
        #
        # Alternatively, if you prefer to declare them only once, you can
        # do so here, using self.global_fixtures:
        #
        # self.global_fixtures = :table_a, :table_b
        #
        # If you declare global fixtures, be aware that they will be declared
        # for all of your contexts, even those that don't use them.
      end
    end
  end
end
