require File.dirname(__FILE__) + '/../../../spec_helper'
require 'hpricot' # Needed to compare generated with wanted HTML

describe "HtmlFormatter" do
  ['--diff', '--dry-run'].each do |opt|
    it "should produce HTML identical to the one we designed manually with #{opt}" do
      root = File.expand_path(File.dirname(__FILE__) + '/../../../..')
      suffix = PLATFORM == 'java' ? '-jruby' : ''
      expected_file = File.dirname(__FILE__) + "/html_formatted-#{VERSION}#{suffix}.html"
      raise "There is no HTML file with expected content for this platform: #{expected_file}" unless File.file?(expected_file)
      expected_html = File.read(expected_file)
      raise "There should be no absolute paths in html_formatted.html!!" if (expected_html =~ /\/Users/n || expected_html =~ /\/home/n)

      Dir.chdir(root) do
        args = ['failing_examples/mocking_example.rb', 'failing_examples/diffing_spec.rb', 'examples/stubbing_example.rb',  'examples/pending_example.rb', '--format', 'html', opt]
        err = StringIO.new
        out = StringIO.new
        Spec::Runner::CommandLine.run(
          args,
          err,
          out,
          false
        )

        seconds = /\d+\.\d+ seconds/
        html = out.string.gsub seconds, 'x seconds'
        expected_html.gsub! seconds, 'x seconds'

        if opt == '--diff'
          # Uncomment this line temporarily in order to overwrite the expected with actual.
          # Use with care!!!
          # File.open(expected_file, 'w') {|io| io.write(html)}

          doc = Hpricot(html)
          backtraces = doc.search("div.backtrace").collect {|e| e.at("/pre").inner_html}
          doc.search("div.backtrace").remove

          expected_doc = Hpricot(expected_html)
          expected_backtraces = expected_doc.search("div.backtrace").collect {|e| e.at("/pre").inner_html}
          expected_doc.search("div.backtrace").remove

          doc.inner_html.should == expected_doc.inner_html

          expected_backtraces.each_with_index do |expected_line, i|
            expected_path, expected_line_number, expected_suffix = expected_line.split(':')
            actual_path, actual_line_number, actual_suffix = backtraces[i].split(':')
            File.expand_path(actual_path).should == File.expand_path(expected_path)
            actual_line_number.should == expected_line_number
          end
        else
          html.should =~ /This was a dry-run/m
        end
      end
    end
  end
  
end
