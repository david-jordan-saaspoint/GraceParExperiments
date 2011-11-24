require 'rubygems'
require 'httparty'
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
  respond_to :js, :only =>[:selectedfield, :selectedcontactfield]

 def index
    # this needs to come from sessions details in html header
      if params[:sid]
        session[:orgId] = params[:orgid]
     #session[:sfdc_id] = "005U0000000YmtlIAC"
        session[:sfdc_id] = params[:uid]
        @pardb = Pardb.find_by_sfdc_id(session[:sfdc_id])
        session[:un] = @pardb.par_un
        session[:pw] = @pardb.par_pw
        session[:sid] = params[:sid]
        end_point = params[:endPointUrl]
        end_uri = URI.parse(end_point)
        session[:uri] = end_uri.to_s
 #      session[:sfdc_un] = "grace@par-dev.com"
 #      session[:sfdc_pw] = "Saaspoint12VmnWWoESfynbRW4RqG754SXD"
  #      session[:un] = 'aviord4@utveckling' 
  #      session[:pw] = 'K5MeMmPP'
  #      session[:sid]= "00DU0000000ITUe!ASAAQJgN9OMCVYAvqNYGq5kARo7E2lh8JSgnvsWxlp5IdDz6vkthwPDlNSt0iTfnpxQ3uU2BJuW3_BexPRKTyAU4uW3e8Cen"
   #     session[:uri] = "https://na12.salesforce.com"
   #     session[:orgId] = "00DU0000000ITUe"
   #     session[:sfdc_id] = "005U0000000Ymtl"
   
      end
     
      p  "session sid  = " , session[:sid]
     # @message = params[:sfdcid]
  end
  
  def populate_from_describe(tname, stable)
         
      	client = Databasedotcom:: Client.new 
        client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
        
        orgId = session[:orgId]
    	# result_hash = Hash.new
    	  if tname == "selectedfields"
    	     account_class = client.materialize("Account")
  	    #client.describe_sobject('Account')
     	    result_hash= client.describe_sobject('Account')
     	  else
     	    contact_class = client.materialize("Contact")
        #client.describe_sobject('Account')
          result_hash= client.describe_sobject('Contact')
        end
     	  result_hash['fields'].each do |ele|
        if ele['updateable']
          sfdctable = stable.create(:fieldname => ele['name'], :fieldtype => ele['soapType'], :fieldlabel => ele['label'], :orgid => session[:orgId])
        end
     end 
     @sfdctables = stable.where(" fieldname not in (select sfdcfield from selectedfields where orgid= '#{@orgId}') and orgid = '#{@orgId}' " ).order("fieldname")
  end
 
  def fieldlist
       # select all records from Sfdctable, Partable and Selectedfields table for the org
     # @orgId= session[:orgId]
      @sfdclist = session[:sfdclist]
      @parlist = session[:parlist]
      @selectedfields = session[:selectedfields]
  end
  def accountfieldlist
    session[:flag] = "A"
    fieldlisthelper(Sfdctable,Selectedfield,Partable)
    redirect_to :controller => 'welcome' , :action => 'fieldlist'
  end
  def fieldlisthelper(stable,seltable,ptable)
     seltable == Selectedfield ? tabname = "selectedfields" : tabname = 'selectedcontactfields'
     
     @orgId = session[:orgId]
     
      @sfdclist = Array.new
      @sfdctables = stable.where(" fieldname not in (select sfdcfield from #{tabname} where orgid= '#{@orgId}') and orgid = '#{@orgId}' " ).order("fieldname")
      @sfdctables
      if(@sfdctables.blank?)
          @sfdctables = populate_from_describe(tabname, stable)
      end    
      @sfdctables.each do |sfdctable|
        @sfdclist.push(sfdctable.fieldlabel.sub("," , "|").sub("'",""))
      end
      @sfdclist = @sfdclist.sort
      @parlist = Array.new
      @par = ptable.where(" fieldname not in (select parfield from #{tabname} where orgid= '#{@orgId}') and orgid = '#{@orgId}' " ).order("fieldname")
      @par.each do |paritem|
        @parlist.push(paritem.fieldname)
      end
   #   @parlist = @parlist.sort
      @selectedfields = Hash.new
      @sf = seltable.find_all_by_orgid(@orgId)
      @sf.each do |sfitem|
        @selectedfields[sfitem.parfield] = sfitem.sfdcfield
      end
      session[:sfdclist] = @sfdclist
      session[:parlist] = @parlist
      session[:selectedfields] = @selectedfields
  end
  def selectedfield
    @orgId = session[:orgId]
    @selectedfields = Selectedfield.find_all_by_orgid(@orgId)
  end
  
  def selectedfieldPersist
    fieldpersist(Sfdctable, Selectedfield)
   # redirect_to(session[:uri])
    
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
    
  # all contacts field method
  def selectedcontactfield
    @orgId = session[:orgId]
    @selectedcontactfields = Selectedcontactfield.find_all_by_orgid(@orgId)
  end
  
  def contactfieldlist
     fieldlisthelper(Contactsfdctable,Selectedcontactfield,ContactPartable)
     session[:flag] = "C"
     redirect_to :controller => 'welcome' , :action => 'fieldlist'
  end
  def fieldpersist(sftable, selectable)
    @orgId = session[:orgId]
    @form_params = Hash.new
    @form_params = params[:field_mapping]
    sfdctables = sftable.find_all_by_orgid(@orgId, :select => "fieldname, fieldlabel")
     # To do: Persist data here - first delete all the records for the org and re insert the selected ones
    selectable.delete_all(:orgid => @orgId)
    @form_params.each do |val| 
 #     Debugger.debugger()
  #    Debugger.start()
      fieldname = replaceFieldlabel(val[1], sfdctables)
      selectedfield =selectable.create(:parfield => val[0], :sfdcfield => fieldname, :orgid =>@orgId)
    end
    
 #   p params.class
 # Debugger.stop()
      
  end
  def selectedcontactfieldPersist
    fieldpersist(Contactsfdctable, Selectedcontactfield)
  end
  def hash_for_js(ruby_hash)
  js_params = ruby_hash.map {|k,v| "'#{k}': '#{v}'"}.join(",")
  "$H({#{js_params})"
  end  
  
  def session_validate
    session[:parId] = params[:parId]
    session[:uri] = params[:endPointUrl]
    client = Databasedotcom:: Client.new 
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    client
  end 
  
  def contact_unsubscribe
    contactIdArray = Array.new
    contactId = params[:contactId]
    contactIdArray.push(contactId)
    perform_unsubscribe(contactIdArray)
    redirect_post_update(contactId)
  end
  def perform_unsubscribe(contactId)
    p contactId
    client = session_validate
    contact_class = client.materialize("Contact")
    contactId.each  do |contact|
      client.update("Contact",  contact, {"PAR121__parId__c" => "", "PAR121__Subscribed__c" => false})
    end
   
  end
  
  def redirect_post_update(path)
    uri = URI.parse(session[:uri])
    uri = "https://" + uri.host + "/" +  path
    redirect_to uri
  end
  def account_unsubscribe
    contactsId = Array.new
    client = session_validate
    account_class = client.materialize("Account")
    session[:accountId] = params[:accountId]
    
    contactsId= find_contacts(session[:accountId],client)
    perform_unsubscribe(contactsId)
    client.update("Account",  session[:accountId], {"PAR121__parId__c" => "", "PAR121__Subscribed__c" => false})
    redirect_post_update(session[:accountId])
  end
  def find_contacts(accountId, client)
    contactsId = Array.new
    query_result =  client.query("select Id  from Contact where AccountId = '#{session[:accountId]}' and PAR121__parId__c != '' ")
    query_result.each do |rec|
      contactsId.push(rec["Id"])
    end
    contactsId
  end
  
end
