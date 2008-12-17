class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  before_filter :get_pages_for_tabs, :get_sub_tabs
  def index
    @pages = Page.find(:all, :order => "pages.lft", :include => :parent)
    if params[:id].blank?
    @page = Page.find(:first)
    else
    @page = Page.find(params[:id])
    end
    @subpages = Page.find(:all, :conditions => ["parent_id = ?", params[:id]])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Den nye siden ble lagret.'
        format.html { redirect_to(@page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Siden ble oppdatert.'
        format.html { redirect_to(@page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def move_higher
    @page = Page.find(params[:id])
 
    if @page.move_higher
      flash[:notice] = "Page successfully moved"
    else
      flash[:notice] = "You cannot move this Page any higher"
    end
 
    redirect_to pages_url
  end
 
  # POST /categories/1/move_lower
  def move_lower
    @page = Page.find(params[:id])
 
    if @page.move_lower
      flash[:notice] = "Page successfully moved"
    else
      flash[:notice] = "You cannot move this Page any lower"
    end
 
    redirect_to pages_url
  end
  
  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
end
