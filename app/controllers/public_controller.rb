class PublicController < ApplicationController
  skip_before_filter :login_required
  before_filter :set_all_categories, :recent_posts, :set_all_levels, :recent_videos, :recent_guides, 
                :instantiate_controller_and_action_names, :get_pages_for_tabs, :get_sub_tabs, :get_tags
 
  layout "public"
  
  def index
    
    @page = Page.find_by_name(params[:name], :include => [:parent])
    
    @levels = Level.find(:all)
    
    
  end
  
  def tag
    @tag = Tag.find(params[:id])
   
    @posts = Post.find_tagged_with(@tag, :include => [:author, :comments, :level],
    :order => "posts.created_at DESC")
    render(:action => 'blogg')
    @levels = Level.find(:all)  
  end
  
  def blogg
    @posts = Post.search(params[:search])
    
  end
  
  def view_post
    @post = Post.find(params[:id], :include => [:author, :categories, :approved_comments])
    
  
    render(:template => 'shared/view_post')
  end
  
  def add_comment
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:id])
    if simple_captcha_valid?
    
    @comment.post = @post
    @comment.status = "nye"
    if @comment.save
      flash[:notice] = "Du har lagt til en kommentar."
      redirect_to(:action => "view_post", :id => @post.id)
    else
      render(:template => 'shared/view_post')
    end
  else
    
   flash[:notice] = "Du skrev ikke koden riktig. Prøv igjen"
   render(:template => 'shared/view_post')
    end
   
  end
  
   def category
    @posts = Post.find(:all, :include => [:author, :categories], 
    :conditions => ["status = 'Offentlig' AND categories.id = ?", params[:id]], 
    :order => "posts.created_at DESC")
    render(:action => 'blogg')
  end
   
   def level 
    @posts = Post.find(:all, 
    :include => [:author, :categories], 
    :conditions => ["status = 'Offentlig'AND level_id = ?", params[:id]],
    :order => "posts.created_at DESC")
    render(:action => 'blogg')
  end
  
  def type 
    @posts = Post.find(:all, 
    :include => [:author, :categories], 
    :conditions => ["status = 'Offentlig'AND slag = ?", params[:slag]],
    :order => "posts.created_at DESC")
    render(:action => 'blogg')
  end
  
  
end
