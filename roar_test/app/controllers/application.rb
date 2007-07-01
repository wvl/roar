class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  session :session_key => '_harness_session_id'
  before_filter :login_from_cookie
end
