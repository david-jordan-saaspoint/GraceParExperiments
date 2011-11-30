class Salesforce::SitesController < ApplicationController
  # GET /salesforce_sites
  # GET /salesforce_sites.xml
  def index
    @salesforce_sites = Salesforce::Site.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salesforce_sites }
    end
  end

  # GET /salesforce_sites/1
  # GET /salesforce_sites/1.xml
  def show
    @site = Salesforce::Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /salesforce_sites/new
  # GET /salesforce_sites/new.xml
  def new
    @site = Salesforce::Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /salesforce_sites/1/edit
  def edit
    @site = Salesforce::Site.find(params[:id])
  end

  # POST /salesforce_sites
  # POST /salesforce_sites.xml
  def create
    @site = Salesforce::Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to(@site, :notice => 'Salesforce::Site was successfully created.') }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salesforce_sites/1
  # PUT /salesforce_sites/1.xml
  def update
    @site = Salesforce::Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to(@site, :notice => 'Salesforce::Site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salesforce_sites/1
  # DELETE /salesforce_sites/1.xml
  def destroy
    @site = Salesforce::Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(salesforce_sites_url) }
      format.xml  { head :ok }
    end
  end
end
