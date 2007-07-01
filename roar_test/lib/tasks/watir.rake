require 'spec/rake/spectask'

report_dir = File.expand_path(File.dirname(__FILE__) + '/../../spec/report')

desc "Run Watir"
Spec::Rake::SpecTask.new('watir') do |t|
  t.spec_files = FileList['spec/watir/**/*.rb']
  t.spec_opts = ['--require', 'spec/spec_helper', '--format', 'Spec::Ui::WebappFormatter']
  t.out = "#{report_dir}/report.html"
end

task :clean_report do
  img_dir = "#{report_dir}/images"
  ENV['RSPEC_IMG_DIR'] = img_dir
  FileUtils.rm_rf(report_dir) if File.exist?(report_dir)
  FileUtils.mkdir_p(img_dir)
end

task :watir => :clean_report
task :default => :watir