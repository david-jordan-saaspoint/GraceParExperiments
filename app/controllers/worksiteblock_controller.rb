  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  require 'databasedotcom'
  require 'will_paginate/array'
  require 'uri'

class WorksiteblockController < ApplicationController
 # include Databasedotcom::Rails::Controller 
  include HTTParty
  include Nokogiri
  include Databasedotcom
  before_filter :authentication_check
  
  def initialize
   
    @contacts_hash ||= Hash.new # Hash of {worksiteParId, contact_field_array}
    @mapped_data = Array.new
    @contacts_selected = Hash.new
    @accounts_selected = Array.new
    @mapped_hash= Hash.new
    @contact_hash = Hash.new
    @par_id_to_account_id_hash = Hash.new
    @criteria = Array.new
    @dup_account = {}
 #   @dup_accId = []
    @dup_acc_sel = []
  end
#  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  def authentication_check
     p "$$$$$ in authentication check of worksite controller $$$$$$$$$$$"
     @un = session[:un]
     @pw = session[:pw]
     self.class.basic_auth @un, @pw
  end

  def initialize_session_vars
  # initialize all  session parameters for this task
        session[:account_selected]= []
        session[:contact_selected] = {}
        session[:contacts_hash]= []
        session[:criteria] = []
        session[:criteriahash] = {}
        session[:offset] = 0
        session[:tot_records] =0
        session[:tot_pages] = 0
        session[:page] = 1
        session[:maxSize] = 25
        session[:dup_account] = []

  end
  def paruser
      initialize_session_vars
      @mapped_country= Array.new
      
      #session[:country].each do |rec| 
      #  @mapped_country.push(rec["description"].split(" - ").length == 1 ? rec["description"].capitalize : (rec["description"].split(" - ")[1] == "UK" ? "United Kingdom" : rec["description"].split(" - ")[1].capitalize))
      #  @mapped_country.sort!
      @mapped_country = session[:country].values
     # end
      @authentication = params[:authentication]
  end
  def search_criteria_populate
    criteria = Hash.new
    criteria["wn"] = params[:worksite].capitalize if params[:worksite]
    #criteria["cny"] = (params[:country].split(" - ").length == 1 ? params[:country] : params[:country].split(" - ")[1]).capitalize if params[:country]
    
    criteria["cny"] = session[:country].key(params[:country])
    criteria["add"] = params[:address].capitalize if params[:address]
    criteria["wgc"] = params[:city].capitalize if params[:city]
    criteria["zp"] = params[:zipcode]
    criteria["phn"] = params[:phone]
    criteria["gno"] = params[:group]
  #  criteria["fn"] = params[:firstname].capitalize if params[:firstname]
  #  criteria["ln"] = params[:lastname].capitalize if params[:lastname]
  #  criteria["em"] = params[:email]
    
    if criteria["fn"] or criteria["ln"] or criteria["em"].blank? == false
      
     # fetch_contacts(criteria)
    end 
    criteria
  end
  def fetch_contacts(criteria)
    if criteria["fn"].blank? == false
      key = "fn"
      value = criteria["fn"]
    elsif criteria["ln"].blank? == false
      key = "ln"
      value = criteria["ln"]
    elsif criteria["email"].blank? == false
      key = "em"
      value = criteria["em"]
    end
     get_contacts(key, value)
     redirect_to(:controller => 'worksiteblock', :action => "display_contacts")
  end
     #searches the database for data based on search criteria
  def find_by_wn
       if params[:commit] == "Search"
           search_by_wn
       elsif params[:commit] == "Cancel"
          uri = URI.parse(session[:uri])
          uri = "https://" + uri.host + "/001/o"
          redirect_to uri, :target => "_blank"
       else
         search_by_wn
       end
  end
  def search_by_wn
      criteria = Hash.new
      criteria = session[:criteria].blank? == true ? search_criteria_populate : session[:criteriahash] 
    
      if  check_hash_empty?(criteria) == false 
       
     #   initialize_session_vars(true)
         theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml'
        
        resp = self.class.get(theUrl, :query => {:maxSize => session[:maxSize], :offset => session[:offset], :worksiteName => criteria["wn"], :worksiteGeneralCity => criteria["wgc"], :systemId => criteria["cny"], :worksiteGeneralAddress => criteria["add"], :worksitePostalZipCode => criteria["zp"], :phone => criteria["phn"], :groupNumber => criteria["gno"]})
        resp_hash = resp.parsed_response
        session[:tot_records] = resp_hash["S_W_4"]["WorksiteSearchResult"]["hitsTotal"].to_i
        if resp_hash["S_W_4"]["WorksiteSearchResult"]["hitsTotal"].to_i > 100
          too_many_rows
        else
          session[:tot_pages] = resp_hash["S_W_4"]["WorksiteSearchResult"]["hitsTotal"].to_f / resp_hash["S_W_4"]["WorksiteSearchResult"]["hitsReturned"].to_f if resp_hash["S_W_4"]["WorksiteSearchResult"]["hitsReturned"].to_f == session[:maxSize]
         
        end
        resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
        # p resp_hash["S_W_4"]["WorksiteSearchResult"]."hitsTotal"
        @mapped_data = read_from_array(resp_data_array) if resp_data_array.blank? == false
      # @mapped_data = resp_data_array if resp_data_array.blank? == false
        session[:mapped_data] = @mapped_data
     #   @mapped_data = @mapped_data.paginate :page=>params[:page],  :per_page => session[:maxSize]
        # @contacts_hash = @contacts_hash
      #   criteria = {}
      #   session[:flag] = "y"
      elsif session[:flag] == "y"
        show_contacts
      else
        @message = "Enter criteria"
        session[:criteria] =[]
        session[:criteriahash] = {}
        redirect_to :controller => "worksiteblock" , :action => "paruser" , :id => "Insufficient search criteria"
      end
   end
   def too_many_rows
      session[:criteria] =[]
      session[:criteriahash] = {}
      @message = "Too many rows returned. Check the search criteria"
      redirect_to(:controller => 'worksiteblock', :action => "paruser" , :id => @message)
   end
   def fetch_account_info
       
   end
   def show_contacts
     @mapped_data = session[:mapped_data] 
  #   @mapped_data = @mapped_data.paginate :page=>params[:page] ,  :per_page => session[:maxSize]
     @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
     @criteria = session[:criteria]
  end
  def calc_totpages
    session[:tot_pages] = session[:tot_records]/session[:maxSize]
  end
   def show_more_records
      session[:maxSize] = 50
      calc_totpages
      show_next_page
      #show_contacts
   end
   def show_next_page
      search_by_wn
      redirect_to(:controller => 'worksiteblock', :action => "show_contacts")
   end
  
   
   def show_less_records
      session[:maxSize] = 25
      calc_totpages
      show_next_page
   end

   def check_hash_empty?(criteria)
      rtnval = true
      criteria.each do |k,v|
        if  v.blank? == false
           @criteria.push(v) 
           rtnval = false if @criteria.length > 1
        else
        end
     end
  p   session[:criteria] = @criteria
      session[:criteriahash] = criteria
     return rtnval
   end 
   
   def get_contacts( param, value)
     p "from contacts"
       key = :worksiteId if param == "par"
       key = :contactFirstName if param == "fn"
       key = :contactLastName if param == "ln"
       key = :email if param == "em"
       
       @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
       theUrl = 'https://obo.par.se/itb/doc/S-C-1.xml' 
       resp = self.class.get(theUrl, :query => {key => value})
       resp_hash = resp.parsed_response
        if resp_hash["S_C_1"]["ContactSearchResult1"]["hitsTotal"].to_i > 100
          too_many_rows
        else
          session[:tot_pages] = resp_hash["S_C_1"]["ContactSearchResult1"]["hitsTotal"].to_f / resp_hash["S_C_1"]["ContactSearchResult1"]["hitsReturned"].to_f if resp_hash["S_C_1"]["ContactSearchResult1"]["hitsReturned"].to_f == session[:maxSize]
       end
      
       resp_data_array = resp_hash["S_C_1"]["ContactSearchResult1"]["Hit"]
       if resp_data_array.blank? == false
          @contacts_hash[value]= read_from_array(resp_data_array)
        # @contacts_hash[value]= resp_data_array
       else
          @contacts_hash[value]= [{"FirstName" => "No contacts available"}]
       end
        # store selected contacts just for checkboxes\
       params[:accountPar] = nil
       session[:contacts_hash] = @contacts_hash
      
        @contacts_hash                 
   end
   def verify_accounts_selected
       if params[:par_idset].blank? == false
         checked_accounts = params[:par_idset]
         checked_accounts.each do |accountset|
           account = accountset[1]
           @accounts_selected.push(account) if @accounts_selected.include?(account) == false
         end
       end
       @accounts_selected.uniq
    end
  
   def store_selected_contacts
     contactsArray = Array.new
     companyId = ""
      @accounts_selected = session[:account_selected].uniq
      @contacts_selected = session[:contact_selected]
      if params[:par_contactset].blank? == false
          params[:par_contactset].each do  |contactpar|
             contactsArray = Array.new
              contactset = contactpar[1]
              companyId = contactset.split(" - ")[1]
                @contacts_selected.each {|key, value|  if key ==  companyId then contactsArray = value end }          
                 # contactsArray = @contacts_selected[companyId]
                  contactId = contactset.split(" - ")[0]
                  contactsArray.push(contactId)
                  contactsArray = contactsArray.uniq
                  @contacts_selected[companyId] = contactsArray
                  @accounts_selected.push(companyId)
                  @accounts_selected = @accounts_selected.uniq
           end
     end
       # updates selected account even if no contacts were selected
     verify_accounts_selected
     @accounts_selected.uniq
#     p "session variables before update", session[:contact_selected], session[:account_selected]
     session[:contact_selected] = @contacts_selected if @contacts_selected.blank? == false
     session[:account_selected] = @accounts_selected if @accounts_selected.blank? == false
     p  session[:contact_selected]
     p  session[:account_selected]
 end
 def read_from_array(xmlarray)
   # this method is needed to fetch multiple as well as single records
     counter =0
     mapped_data = Array.new
     xmlarray.each do |ele|
          if ele.class ==Hash
            resp_array = ele
            mapped_data[counter] =resp_array
            counter += 1
          else
            resp_array = xmlarray
            mapped_data[counter] =resp_array
          end  
      end
      mapped_data
 end
    # checks for user requirement single or multiple
 def get_user_req
     if params[:commit] == "Add to SFDC"   
      
       p "session sid" , session[:sid]
       p "session uri" , session[:uri]
      client = Databasedotcom:: Client.new #:client_id =>     "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret =>    "5686796735919094998", :debugging =>true
      #    client.authenticate :username => session[:sfdc_un], :password => session[:sfdc_pw]
        # session[:sid]= '00DU0000000ITUe!ASAAQDaRfoPHo8E4F_UuQsZAo6Z4LcIyS_S62qCNqfkuzmR2uKE5tGQ5Yb6FFDpFzhThO_b.HhMF3cGFEacyCe3fR5.vQafQ'
      client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
      account_class = client.materialize("Account")
      session[:client] = client
       # refresh all contacts and accounts selected by user
       @contacts_selected = {}
       @accounts_selected = []
       store_selected_contacts
      # inserts accounts and identifies duplicates
       query_selected_fields(client, "PAR121__parId__c", "upsert")
       if session[:dup_account].blank? == true
         p session[:dup_account]
    # finds and inserts contacts for the accounts that were inserted
          complete_contact_update
      else
        p "deal with duplicates"
        p session[:dup_account]
        redirect_to(:controller => 'worksiteblock', :action => "fetch_duplicate_account")
      end
    #    redirect_to(:controller => 'worksiteblock', :action => "find_by_wn")
   elsif params[:commit] == "Next page "
        calc_offset("next")
        populate_before_redirect
        show_next_page
        
   elsif params[:commit] == "Show more "
       populate_before_redirect
       show_more_records
   elsif params[:commit] == "Show less "
       populate_before_redirect
       show_less_records
       
   elsif params[:commit] == "Prev page "
        calc_offset("prev")
        populate_before_redirect
        show_next_page
      
   else  # one of the show contacts button is pressed
       label = params[:commit]
       accountpar = label.split[2]
       
       get_contacts("par", accountpar)
       populate_before_redirect
       @criteria = session[:criteria]
  #        redirect_to(:controller => 'worksiteblock', :action => "find_by_wn")
       redirect_to(:controller => 'worksiteblock', :action => "show_contacts")
     end
  end
  def complete_contact_update
    client = session[:client]
    get_account_ids(session[:account_selected], client)
          p "selected account ",  session[:account_selected]
          p "selected contacts" , session[:contact_selected]
         # reset session varaibles
        #  initialize_session_vars
         # verify number of accounts updated and reroute
        
    redirect_post_commit
       
  end
 
  def fetch_duplicate_account
  client = session[:client]
  p client

 #   acc_id_string = session[:dup_account].values.flatten.map { |i| "'" + i + "'"}.join(",").gsub('"', "")
  par_id_string = session[:dup_account].map { |i| "'" + i + "'"}.join(",").gsub('"', "")
  p par_id_string
       # fetch all relevant data from Account sobject
    ##@resp_acc = client.query("Select Id,Name,AccountNumber,PAR121__dbId__c, PAR121__parId__c,PAR121__Subscribed__c,PAR121__CompanyNumber__c,PAR121__Legalname__c, PAR121__Department__c,BillingStreet,BillingPostalCode,BillingCity,PAR121__Phone__c,PAR121__Type__c,PAR121__TypeCode__c,PAR121__Status__c, PAR121__StatusCode__c,ShippingStreet,ShippingPostalCode,ShippingCity from Account where id in (#{acc_id_string}) ")
    @resp_acc = client.query("Select Id,Name,AccountNumber,PAR121__dbId__c, PAR121__parId__c,PAR121__Subscribed__c,PAR121__CompanyNumber__c,PAR121__Legalname__c, PAR121__Department__c,BillingStreet,BillingPostalCode,BillingCity,PAR121__Phone__c,PAR121__Type__c,PAR121__TypeCode__c,PAR121__Status__c, PAR121__StatusCode__c,ShippingStreet,ShippingPostalCode,ShippingCity from Account where par121__parId__c in (#{par_id_string}) ")
    @resp_acc
    
  end
  def handle_duplicate_records
    p params[:commit]
    if params[:commit] == "Cancel " 
      session[:dup_account].each do  |par| 
        session[:account_selected].delete(par) 
        session[:contact_selected].delete(par)
      end
      @accounts_selected = session[:account_selected]
      @contact_selected = session[:contact_selected]
      session[:dup_account] = []
        
    else 
      @dup_par = Array.new
      @dup_acc_sel = Array.new
      # update both accounts and track  their account ids
      dup_par =  params[:id]
      dup_par.each { |val| @dup_par.push(val[1]) }
      session[:dup_account].each {|par|   @dup_acc_sel.push(par) }
      @dup_acc_sel = @dup_acc_sel.uniq 
      if params[:commit] == "Update selected "
        query_selected_fields(session[:client], "Id", "update")
      else
        query_selected_fields(session[:client], "Id", "insert") 
      end
  end
  
  if session[:account_selected].blank?
    redirect_post_commit
  else
    redirect_to(:controller => 'worksiteblock' , :action => 'complete_contact_update')
  
  end
  end 
  
  def populate_before_redirect
     @contacts_hash = session[:contacts_hash] 
     @mapped_data = session[:mapped_data]
     store_selected_contacts
  end
  def calc_offset(cond)
    offset = session[:offset].to_i
    if  session[:tot_records] > offset + session[:maxSize].to_i  and cond == "next"
      session[:offset] = offset + session[:maxSize].to_i
      session[:page] = session[:page].to_i + 1
      p "page number :" , session[:page], session[:offset]
    elsif  cond == "next"
      session[:offset] = offset - session[:maxSize].to_i
      session[:page] = session[:page].to_i - 1
      p "page number :" , session[:page], session[:offset]
    else
      session[:offset] = 0
      session[:page] = 1
    end
   
 end
  
  def query_selected_fields(client, fieldname, action)
    orgId = session[:orgId]
    query_selected = Selectedfield.find(:all, :select => "sfdcfield, parfield", :conditions => "orgid = '#{orgId}'")
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    if fieldname == "PAR121__parId__c" 
      @accounts_selected.each do |selected_par|
          upsertAccounts(selected_par, query_selected, theUrl, client, fieldname, action)
      end
    else
      @dup_acc_sel.each do |selected_par|
          upsertAccounts(selected_par, query_selected, theUrl, client, fieldname, action)
      end
    end
  end
 
  # This is a helper method for get_user_req to loop through multiple reqs
   def upsertAccounts(selected_par, query_selected, theUrl, client, fieldname, action)
     p" ++++++++++++++upsertaccount +++++++"
  #   @dup_accId = Array.new
     @dup_account = Array.new
     @dup_account = session[:dup_account]
      respaccount = self.class.get(theUrl, :query => {:worksiteId => selected_par}).body
     
      doc=Nokogiri::XML(respaccount)
            query_selected.each do |field|
            query_result = field.parfield
            query_result = "WorksiteBlock/" + query_result
            sfdckey = field.sfdcfield    
            # fetch the value for the selected fields from the xml file
            doc.xpath(query_result).each do |node|
              @mapped_hash[sfdckey] = node.children.to_s 
            end 
          end 
          @mapped_hash["PAR121__Subscribed__c"] = true
          p @mapped_hash
          
      # call insertsobject.rb to insert the mapped hashes into the S Object
      #InsertSObject.createclientobject(@mapped_hash, selected_par)
      begin
          p "account insert"
          p action
          if action == "insert"
            @mapped_hash["PAR121__parId__c"] = selected_par
            client = session[:client]
            client.create("Account", @mapped_hash)
             
          elsif action == "update"
            @dup_par.each { |accid | Account.upsert(fieldname, accid, @mapped_hash) }
          else
            p "upsert"
            Account.upsert(fieldname, selected_par, @mapped_hash) 
          end
          p "account inserted"
      rescue Exception => e
          p "rescue"
  #         e.response.body.split(',').each do |rec|
      #    p rec.sub("]", '').split('/')[6][0..-5]
   #        pos =  rec.index("001")
    #       @dup_accId.push(rec[pos, 15])
    #      end
    #      @dup_account[selected_par]  = @dup_accId
    #      @dup_account.values
   #       @dup_accId = []
         @dup_account.push(selected_par)
         session[:dup_account] = @dup_account
          
    #    p "Caught code #{e.error_code}"
     end
      
  end
    
  def get_account_ids(par_id, client)
    par_id_string = par_id.map { |i| "'" + i + "'" }.join(",")
    par_id_string.gsub('"', "")
#    par_id_string = par_id.to_s.gsub!("[","'").gsub!("]","'")
    queryresp = client.query("SELECT PAR121__parId__c, id FROM Account where PAR121__parid__c in (#{par_id_string}) ")
    queryresp.each do |rec|
       @par_id_to_account_id_hash[rec["PAR121__parId__c"]] =  rec["Id"]
    end
    
    select_contact_details
 end
def select_contact_details
  if session[:contact_selected].blank? == false
      p "contacts"
      @contacts_selected = session[:contact_selected]
      orgId = session[:orgId]
      query_selectedcontacts = Selectedcontactfield.find(:all, :select => "sfdcfield, parfield", :conditions => "orgid = '#{orgId}'")
      insert_contact_details(@par_id_to_account_id_hash,@contacts_selected, query_selectedcontacts )
  end
  end
  
  def insert_contact_details( accountId, contact_par, query_selectedcontacts)
        authenticateContact
        account_Id = ""
        contact_par.each do  |accountpar, contactpar| 
            contactpar.each do |contactId|
              theUrl = 'https://obo.par.se/itb/doc/ContactBlock.xml' 
              resp = self.class.get(theUrl, :query => {:contactId => contactId}).body
              doc=Nokogiri::XML(resp)
              query_selectedcontacts.each do |field|
                query_result = field.parfield
                query_result = "ContactBlock/" + query_result
                sfdckey = field.sfdcfield    
                doc.xpath(query_result).each do |node| 
                    @contact_hash[sfdckey] = node.children.to_s 
                end 
              end
             # pick up the account Id from accountId parameter using accountpar
             account_Id = accountId[accountpar] 
            @contact_hash["AccountId"] = "#{account_Id}"
            @contact_hash["PAR121__Subscribed__c"] = true
            @contact_hash
            Contact.upsert("par121__parId__c", "#{contactId}", @contact_hash)
            p "contact inserted"
           end
      end
   end
  
  def authenticateContact
    client = Databasedotcom:: Client.new #:client_id => "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret => "5686796735919094998", :debugging =>true
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    client_class = client.materialize("Contact")
    orgId = session[:orgId]
  end
  
  def redirect_post_commit
    uri = URI.parse(session[:uri])
        if session[:account_selected].length > 1
           uri = "https://" + uri.host + "/001/o"
       elsif session[:account_selected].length == 0
          uri = "https://" + uri.host + "/001/o"
       else
          uri = "https://" + uri.host + "/" +  @par_id_to_account_id_hash.values[0]
       end
    initialize_session_vars
    redirect_to uri
  end
  
 def updateFromAccountPage
 #  @accounts_selected = Array.new
    session[:orgId] = params[:orgId]
    end_point = params[:endPointUrl]
    session[:uri] = end_point
    session[:sid] = params[:sid]
    session[:accountId] = params[:accountId]
    @accounts_selected.push(params[:parId])
    @dup_acc_sel.push(params[:accountId])
    @par_id_to_account_id_hash[params[:parId]] = session[:accountId]
    session[:account_selected] = @accounts_selected
   
    client = Databasedotcom:: Client.new 
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    account_class = client.materialize("Account")
       # refresh all  accounts selected by user
    query_selected_fields(client, "id", "upsert")
    @dup_acc_sel =[]
    redirect_post_commit
 end
 def updateFromContactPage
    contact_selected = Hash.new
    contacts_array = Array.new
    session[:orgId] = params[:orgId]
    session[:uri] = params[:endPointUrl]
    session[:sid] = params[:sid]
    session[:accountPar] = params[:accountPar]
    session[:accountId] = params[:accountId]
    contacts_array.push(params[:contactPar])
    session[:contactId] = params[:contactId]
    @par_id_to_account_id_hash[session[:accountPar]] = session[:accountId]
    contact_selected[session[:accountPar]] = contacts_array
    session[:contact_selected] = contact_selected
    select_contact_details
    redirect_commit_contact
 end
 def redirect_commit_contact
   uri = URI.parse(session[:uri])
   uri = "https://" + uri.host + "/" +  session[:contactId]
   redirect_to uri
 end
end