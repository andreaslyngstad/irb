ActionController::Routing::Routes.draw do |map|
  map.resources :messages
  
  map.root :controller => "public", :action => "index", :name => "RubyonRails"
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  
  
  map.resources :users
  
  map.resources :categories

  map.resources :comments
  
  map.resource :session

  map.resources :pages, :member => {:move_higher => :post, :move_lower => :post}

  map.resources :posts
  
 
  map.view_blogg "blogg", :controller => 'public', :action => 'blogg'
  map.view_video "videoer", :controller => 'public', :action => 'video'
  map.view_guide "guider", :controller => 'public', :action => 'guide' 
  map.view_cms   "cms", :controller => 'home', :action => 'index'
  
  map.view_tikka "test", :controller => 'public', :action => 'view_post', :id => (:id)
  
  map.view_page ':name', :controller => 'public', :action => 'index'
  
 
  
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.view_post  ":slag/:title", :controller => 'public', :action => 'view_post'
end
