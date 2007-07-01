ActionController::Routing::Routes.draw do |map|
  map.roar :users, :contents, :posts, :links, :tags
  
  map.resources :users, :sessions, :contents, :posts, :links, :tags

  map.home '', :controller => "contents"

  map.login    '/login',         :controller => 'sessions', :action => 'new'
  map.logout   '/logout',        :controller => 'sessions', :action => 'destroy'
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
