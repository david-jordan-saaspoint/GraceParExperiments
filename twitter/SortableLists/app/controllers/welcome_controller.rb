require 'rubygems'
require 'httparty'
require 'ruby-debug'
require 'cgi'
 require 'databasedotcom'


require 'open-uri'
class WelcomeController < ApplicationController
  @authenticated = false
 include HTTParty
 include Databasedotcom
 #This has to be from the sessions data
 #  before_filter :authentication_check, :except => :index
 # @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  respond_to :js, :only =>[:selectedfield]
  
     
  
  def index
     # this needs to come from sessions details in html header
     if session[:orgId].blank?
        session[:orgId] = params[:orgid]
     #session[:sfdc_id] = "005U0000000YmtlIAC"
        session[:sfdc_id] = params[:uid]
     
        @pardb = Pardb.find_by_sfdc_id(session[:sfdc_id])
        session[:un] = @pardb.par_un
        session[:pw] = @pardb.par_pw
#     session[:sfdc_un] = "grace@par-dev.com"
#     session[:sfdc_pw] = "Saaspoint12VmnWWoESfynbRW4RqG754SXD"
      
        session[:sid] = params[:sid]
        end_point = params[:endPointUrl]
        end_uri = URI.parse(end_point)
        session[:uri] = end_uri.to_s
     
      end
     # @message = params[:sfdcid]
  end
  
  def paruser
      @authentication = params[:authentication]
      
  end
  
  def populate_from_describe
     client = Databasedotcom:: Client.new 
     client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
     client.describe_sobject('Account')
     
    # result_hash = Hash.new
     result_hash= client.describe_sobject('Account')
     result_hash['fields'].each do |ele|
        if ele['updateable']
          
          sfdctable = Sfdctable.create(:fieldname => ele['name'], :fieldtype => ele['soapType'], :fieldlabel => ele['label'], :orgId => session[:orgId])
        end
     end 
     
     @sfdctables = Sfdctable.where(" fieldname not in (select sfdcField from selectedfields where orgId= '#{@orgId}') and orgId = '#{@orgId}' " )
     
  end
 
  def fieldlist
      # select all records from Sfdctable, Partable and Selectedfields table for the org
     # @orgId= session[:orgId]
      @orgId = session[:orgId]
      @sfdclist = Array.new
      @sfdctables = Sfdctable.where(" fieldname not in (select sfdcField from selectedfields where orgId= '#{@orgId}') and orgId = '#{@orgId}' " )
      if(@sfdctables.blank?)
          @sfdctables = populate_from_describe
      end    
      
      @sfdctables.each do |sfdctable|
        @sfdclist.push(sfdctable.fieldlabel.sub("," , "|"))
      end
      
       
      @parlist = Array.new
      @par = Partable.where(" fieldname not in (select parField from selectedfields where orgId= '#{@orgId}') and orgId = '#{@orgId}' " )
      @par.each do |paritem|
        @parlist.push(paritem.fieldname)
      end
       
      @selectedfields = Hash.new
      @sf = Selectedfield.find_all_by_orgId(@orgId)
      @sf.each do |sfitem|
        @selectedfields[sfitem.parField] = sfitem.sfdcField
       
      end
  end
  
 
  def selectedfield
    @orgId = session[:orgId]
    @selectedfields = Selectedfield.find_all_by_orgId(@orgId)
    
  end
  
  def selectedfieldPersist
    @orgId = session[:orgId]
    @form_params = Hash.new
    @form_params = params[:field_mapping]
    sfdctables = Sfdctable.find_all_by_orgId(@orgId, :select => "fieldname, fieldlabel")
     # To do: Persist data here - first delete all the records for the org and re insert the selected ones
    Selectedfield.delete_all(:orgId => @orgId)
    
    @form_params.each do |val| 
 #     Debugger.debugger()
  #    Debugger.start()
      fieldname = replaceFieldlabel(val[1], sfdctables)
      selectedfield = Selectedfield.create(:parField => val[0], :sfdcField => fieldname, :orgId =>@orgId)
    end
 #   p params.class
 # Debugger.stop()
      respond_to do |format|
      format.html # selectedfieldPersist.html.erb
      format.json  { render :json => @form_params }
    end
   
  end
  
  def replaceFieldlabel(fieldlabel, sfdctables)
    
      @fieldname = ''
      sfdctables.each do |sfdc|
         if sfdc['fieldlabel'].gsub( ' ','').gsub(",", "|") == fieldlabel || sfdc['fieldname'].gsub( ' ','').gsub(",", "|") == fieldlabel
          @fieldname = sfdc['fieldname']
         end
      end
        @fieldname
   end
    
  def hash_for_js(ruby_hash)
  js_params = ruby_hash.map {|k,v| "'#{k}': '#{v}'"}.join(",")
  "$H({#{js_params})"
end   
end
