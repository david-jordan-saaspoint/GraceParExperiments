require 'rubygems'
require 'httparty'
require 'ruby-debug'
require 'CGI'


require 'open-uri'
class WelcomeController < ApplicationController
  @authenticated = false
 include HTTParty
 #This has to be from the sessions data
 
  @orgId = "123"
#  before_filter :authentication_check, :except => :index
  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  respond_to :js, :only =>[:selectedfield]
  
 
  
  def index
     # this needs to come from sessions details in html header
     @message = params[:sfdcid]
  end
  
  def paruser
      @id = params[:id]
      @pardb = Pardb.find_by_sfdc_id(@id)
      @un = @pardb.par_un
      @pw = @pardb.par_pw
  end
 
  def fieldlist
      # select all records from Sfdctable, Partable and Selectedfields table for the org
      @orgId= '123'
      @fieldlist = Array.new
      @sfdctables = Sfdctable.find_all_by_orgId(@orgId)
      #@sfdctables = Sfdctable.find(:all, :select => 'fieldname')
      #@fieldlist = @sfdctables
      @sfdctables.each do |sfdctable| 
        @fieldlist.push(sfdctable.fieldname)
      end
      
      @parlist = Array.new
      @par = Partable.find_all_by_orgId(@orgId)
      @par.each do |paritem|
        @parlist.push(paritem.fieldname)
      end
      
      @selectedfields = Hash.new
      @sf = Selectedfield.find_all_by_orgId(@orgId)
      @sf.each do |sfitem|
        @selectedfields[sfitem.parField] = sfitem.sfdcField
       
      end
        
      # @fieldlist= Sfdctable.find(:all, :select => "fieldname")
      # @fieldlist = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StatusCode__c"]
  end
  
  def selectedfield
    @orgId = '123'
    @selectedfields = Selectedfield.find_all_by_orgId(@orgId)
    
  end
  
  def selectedfieldPersist
     @orgId = "123"
    @form_params = Hash.new
    @form_params = params[:field_mapping]
     # To do: Persist data here - first delete all the records for the org and re insert the selected ones
    Selectedfield.delete_all(:orgId => @orgId)
    @form_params.each do |val| 
      selectedfield = Selectedfield.create(:parField => val[0], :sfdcField => val[1], :orgId =>@orgId)
    end
    p "inserted into selected table" 
    p "form_params", @form_params
 #    Debugger.debugger()
 #   Debugger.start()
 #   p params.class
 # Debugger.stop()
      respond_to do |format|
      format.html # selectedfieldPersist.html.erb
      format.json  { render :json => @form_params }
    end
   
  end
  def hash_for_js(ruby_hash)
  js_params = ruby_hash.map {|k,v| "'#{k}': '#{v}'"}.join(",")
  "$H({#{js_params})"
end   
end
