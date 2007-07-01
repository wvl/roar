ActionController::Routing::Routes.draw do |map|
  map.connect '', :controller=>'admin'

  map.roar :todos, :collection => { :order => :post, :done => :post, :undone => :post, :delete_checked => :post }
  map.roar :polls

  map.resources :todos, :teams, :polls

  [:sinks, :news_items, :categories, :games].each do |r|
    map.resources r, :member => { :delete => :get }    
  end
  
  map.resources :users, :member => { :delete => :get}, 
    :collection => { :auto_complete => :post }
    
  map.resources :events, :member => { :delete => :get }, 
    :collection => { :preview => :any, :delete_checked => :post }
  
  map.resources :leagues, :member => { :delete => :get } do |league|
   league.resources :divisions, :member => { :delete => :get}
  end
  
  map.resources :forums, :member => { :delete => :get } do |forum|    
    forum.resources :topics, :member => { :delete => :get } do |topic|
      topic.resources :posts, :monitorships
    end
  end

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
