
# self-referential, polymorphic has_many :through plugin
# http://blog.evanweaver.com/articles/2006/06/02/has_many_polymorphs
# operates via magic dust, and courage

require 'active_record'

require 'has_many_polymorphs/reflection'
require 'has_many_polymorphs/association'
require 'has_many_polymorphs/class_methods'

require 'has_many_polymorphs/support_methods'
require 'has_many_polymorphs/configuration'
require 'has_many_polymorphs/base'

class ActiveRecord::Base
  extend ActiveRecord::Associations::PolymorphicClassMethods 
end

require 'has_many_polymorphs/debugging_tools' if ENV['RAILS_ENV'] =~ /development|test/ and ENV['USER'] == 'eweaver'
