class SfdctablesController < ApplicationController
  # GET /sfdctables
  # GET /sfdctables.xml
  def index
    @sfdctables = Sfdctable.paginate :page=>params[:page], :order=>'created_at desc', :per_page =>20
     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sfdctables }
    end
  end

  # GET /sfdctables/1
  # GET /sfdctables/1.xml
  def show
    @sfdctable = Sfdctable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sfdctable }
    end
  end

  # GET /sfdctables/new
  # GET /sfdctables/new.xml
  def new
    @sfdctable = Sfdctable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sfdctable }
    end
  end

  # GET /sfdctables/1/edit
  def edit
    @sfdctable = Sfdctable.find(params[:id])
  end

  # POST /sfdctables
  # POST /sfdctables.xml
  def create
    @sfdctable = Sfdctable.new(params[:sfdctable])

    respond_to do |format|
      if @sfdctable.save
        format.html { redirect_to(@sfdctable, :notice => 'Sfdctable was successfully created.') }
        format.xml  { render :xml => @sfdctable, :status => :created, :location => @sfdctable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sfdctable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sfdctables/1
  # PUT /sfdctables/1.xml
  def update
    @sfdctable = Sfdctable.find(params[:id])

    respond_to do |format|
      if @sfdctable.update_attributes(params[:sfdctable])
        format.html { redirect_to(@sfdctable, :notice => 'Sfdctable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sfdctable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sfdctables/1
  # DELETE /sfdctables/1.xml
  def destroy
    @sfdctable = Sfdctable.find(params[:id])
    @sfdctable.destroy

    respond_to do |format|
      format.html { redirect_to(sfdctables_url) }
      format.xml  { head :ok }
    end
  end
  
  
end