class Salesforce::UsersController < ApplicationController
  # GET /salesforce_users
  # GET /salesforce_users.xml
  def index
    @salesforce_users = Salesforce::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salesforce_users }
    end
  end

  # GET /salesforce_users/1
  # GET /salesforce_users/1.xml
  def show
    @user = Salesforce::User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /salesforce_users/new
  # GET /salesforce_users/new.xml
  def new
    @user = Salesforce::User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /salesforce_users/1/edit
  def edit
    @user = Salesforce::User.find(params[:id])
  end

  # POST /salesforce_users
  # POST /salesforce_users.xml
  def create
    @user = Salesforce::User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'Salesforce::User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salesforce_users/1
  # PUT /salesforce_users/1.xml
  def update
    @user = Salesforce::User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Salesforce::User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salesforce_users/1
  # DELETE /salesforce_users/1.xml
  def destroy
    @user = Salesforce::User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(salesforce_users_url) }
      format.xml  { head :ok }
    end
  end
end
