ActionController::Routing::Routes.draw do |map|
 
  # User routes 
  map.root :controller => "pages"
  map.dashboard "", :controller => "dashboard", :action => "index" 
  map.login "/login", :controller => "user_session", :action => "login"
  map.logout "/logout", :controller => "user_session", :action => "logout" 

  map.register "/register", :controller => "user_session", :action => "register" 
  map.profile "/profile", :controller => "user_session", :action => "profile"
  map.edit_profile "/profile/edit", :controller => "user_session", :action => "edit_profile"

  map.request_reset_password "/reset_password/request", :controller => "user_session", :action => "request_reset_password"
  map.reset_password "/reset_password/:id", :controller => "user_session", :action => "reset_password"

  # Administration panel routes
  map.admin_dashboard "/admin", :controller => "admin/admin_dashboard", :action => "index"

  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :roles
    
  end
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
