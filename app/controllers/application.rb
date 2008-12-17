# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
  
class ApplicationController < ActionController::Base
  
  
  include SimpleCaptcha::ControllerHelpers
  
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  before_filter :login_required, :recent_posts, :recent_videos, :recent_guides,
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5ff9bae5c73b0c12f85fb9d0afda53fa'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
 
  
  def set_all_categories
    @all_categories = Category.find(:all, :order => 'name ASC')
  end
  
  def set_all_levels
    @all_levels = Level.find(:all, :order => "id ASC")
  end
  
  def recent_posts
     @recent_posts = Post.find(:all, :conditions => "status = 'Offentlig' AND slag = 'post'", 
                                     :order => "created_at DESC", :limit => 5)
  end
 
  def recent_videos
     @recent_videos = Post.find(:all, :conditions => "status = 'Offentlig' AND slag = 'video'", 
                                     :order => "created_at DESC", :limit => 5)
  end
  def recent_guides
     @recent_guides = Post.find(:all, :conditions => "status = 'Offentlig' AND slag = 'guide'", 
                                     :order => "created_at DESC", :limit => 5)
  end
 
     
  def instantiate_controller_and_action_names
     @current_action = action_name
     @current_controller = controller_name
  end 
  
  
  
  def get_pages_for_tabs
    @tabs = Page.find_main 
 end
 
 def get_sub_tabs
    @subtabs = Page.find_subpages
 end
 
 def get_tags
    @tags = Post.tag_counts
 end
 
 
end
