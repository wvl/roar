# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # need to include this here only if we turn on roar plugin reloading
  include Roar::Rails::AdminHelper
end
