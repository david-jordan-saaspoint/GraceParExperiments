class Salesforce::AccountsController < ApplicationController
  # GET /salesforce_accounts
  # GET /salesforce_accounts.xml
  def index
    @salesforce_accounts = Salesforce::Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salesforce_accounts }
    end
  end

  # GET /salesforce_accounts/1
  # GET /salesforce_accounts/1.xml
  def show
    @account = Salesforce::Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /salesforce_accounts/new
  # GET /salesforce_accounts/new.xml
  def new
    @account = Salesforce::Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /salesforce_accounts/1/edit
  def edit
    @account = Salesforce::Account.find(params[:id])
  end

  # POST /salesforce_accounts
  # POST /salesforce_accounts.xml
  def create
    @account = Salesforce::Account.new(params[:salesforce_account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Salesforce::Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salesforce_accounts/1
  # PUT /salesforce_accounts/1.xml
  def update
    @account = Salesforce::Account.new(params[:salesforce_account])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Salesforce::Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salesforce_accounts/1
  # DELETE /salesforce_accounts/1.xml
  def destroy
    @account = Salesforce::Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(salesforce_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
