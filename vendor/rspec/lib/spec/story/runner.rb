require 'spec/story/runner/scenario_collector.rb'
require 'spec/story/runner/scenario_runner.rb'
require 'spec/story/runner/story_runner.rb'

module Spec
  module Story
    module Runner
      class << self
        def run_options
          @run_options ||= ::Spec::Runner::OptionParser.new.parse(Array.new(ARGV), $stderr, $stdout, false)
        end
        
        def story_runner
          unless @story_runner
            scenario_runner = ScenarioRunner.new
            Runner.register_exit_hook
            world_creator = World
            @story_runner = StoryRunner.new(scenario_runner, world_creator)
            unless run_options.dry_run
              reporter = ::Spec::Story::Reporter::PlainTextReporter.new($stdout)
              scenario_runner.add_listener(reporter)
              @story_runner.add_listener(reporter)
            end
            if not run_options.formatters.empty?
              documenter = ::Spec::Story::Documenter::PlainTextDocumenter.new($stdout)
              scenario_runner.add_listener(documenter)
              @story_runner.add_listener(documenter)
              world_creator.add_listener(documenter)
            end
          end
          @story_runner
        end
        
        def register_exit_hook
          at_exit do
            Runner.story_runner.run_stories unless $!
            # TODO exit with non-zero status if run fails
          end
        end
        
        def dry_run
          run_options.dry_run
        end
      end
    end
  end
end
