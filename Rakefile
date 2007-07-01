require 'rake'
require 'rake/clean'

task :doc do
  FileList["web/*.md"].each do |file|
    `maruku #{file}`
  end
end