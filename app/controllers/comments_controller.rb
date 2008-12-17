class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    case params[:status]
      when 'godkjent'
        @comments = Comment.find(:all, :conditions => "status = 'godkjent'", :order => 'created_at DESC') 
      when 'spam'
      @comments = Comment.find(:all, :conditions => "status = 'spam'", :order => 'created_at DESC') 
      when 'alle'
       @comments = Comment.find(:all, :order => 'created_at DESC') 
      when 'slett'
        @comments.each do |com| 
          @comment = com.find(params[:id]) 
          @comment.destroy
        end
      else
       @comments = Comment.find(:all, :conditions => "status = 'nye'", :order => 'created_at DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @posts = all_posts
    @comment.status = "nye"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.status = "nye"
    if simple_captcha_valid?
           respond_to do |format|
          if @comment.save
            flash[:notice] = 'Comment was successfully created.'
            format.html { redirect_to(@comment) }
            format.xml  { render :xml => @comment, :status => :created, :location => @comment }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
            end
          end
      else
        respond_to do |format|
        flash[:notice] = 'Koden var feil, prøv igjen. Du trenger ikke å bry deg om store eller små boklstaver.'
        format.html { render :action => "new" }
       end
      end
   
   
  end

def set_status
  
    
    begin        
      status = params[:commit] || "" 
      checked_items = params[:commentlist]
      if status == "Slett"
      checked_items.each do |com| 
      Comment.delete(com)
      
      end
    else
      checked_items.each do |id|   
      Comment.update(id.to_i, :status => status.downcase)
      end
    end
    
     
      flash[:notice] = "De valgte kommentarene ble oppdatert"
      redirect_to(:controller => "comments", :action => "index")
      
    rescue
      flash[:notice] = "Det oppstod en ukjent feil"
      redirect_to(:controller => "comments", :action => "index")
    
    end
  end
 end 
private 

def all_posts
  return Post.find(:all, :order => "title ASC").collect {|p| [p.title, p.id]}
  
end
