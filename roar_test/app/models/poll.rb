class Poll < ActiveRecord::Base
  has_many :poll_options, :order=>'poll_options.option'

  roar_crud_association :poll_options, :option
  
end
