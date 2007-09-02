ENV["RAILS_ENV"] = "test"
RAILS_ROOT = File.dirname(__FILE__)+'/../../roar_test'
require "#{RAILS_ROOT}/config/environment"

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../vendor/criteriaquery/lib'
# require 'rubygems'
#require 'activesupport'
# require 'query' 
%w(actions action column form field filter collection base).each { |klass| require "roar/#{klass}" }
require 'roar/rails/act_methods'
require 'roar/rails/base_controller'
require 'roar/settings'

