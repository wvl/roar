Tag

class ApplicationController < ActionController::Base
  session :session_key => '_tumblelog_session_id'
  
  include AuthenticatedSystem
  before_filter :login_from_cookie, :login_required_for_admin, :assign_user

  def assign_user
    User.current_user = current_user
  end
  
  def login_required_for_admin
    login_required if request.path.match(/^\/admin/) && User.count > 0
  end

end
