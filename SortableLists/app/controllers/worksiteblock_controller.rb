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
    "initialize"
    @contacts_hash ||= Hash.new # Hash of {worksiteParId, contact_field_array}
    @mapped_data = Array.new
    @contacts_selected = Hash.new
    @accounts_selected = Array.new
    @mapped_hash= Hash.new
    @contact_hash = Hash.new
    @par_id_to_account_id_hash = Hash.new
    @criteria = Array.new
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

  end
  def paruser
      initialize_session_vars
      @mapped_country= Array.new
      session[:country].each do |rec| 
        @mapped_country.push(rec["description"].split(" - ").length == 1 ? rec["description"].capitalize : (rec["description"].split(" - ")[1] == "UK" ? "United Kingdom" : rec["description"].split(" - ")[1].capitalize))
      #  @mapped_country.sort!
      end
      @authentication = params[:authentication]
  end
  def search_criteria_populate
    criteria = Hash.new
    criteria["wn"] = params[:worksite].capitalize if params[:worksite]
    #criteria["cny"] = (params[:country].split(" - ").length == 1 ? params[:country] : params[:country].split(" - ")[1]).capitalize if params[:country]
    session[:country].each do |rec|
      if rec["description"] == params[:country]
         criteria["cny"] = rec["systemId"]
      end
    end
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
          redirect_to uri
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
       # @mapped_data = read_from_array(resp_data_array) if resp_data_array.blank? == false
       @mapped_data = resp_data_array if resp_data_array.blank? == false
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
	
   def show_more_records
 	    session[:maxSize] = 50
	    show_next_page
      #show_contacts
   end
   def show_next_page
      search_by_wn
      redirect_to(:controller => 'worksiteblock', :action => "show_contacts")
   end
  
   
   def show_less_records
      session[:maxSize] = 25
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
       key = :worksiteId if param == "par"
       key = :contactFirstName if param == "fn"
       key = :contactLastName if param == "ln"
       key = :email if param == "em"
       p key
	     @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
	 #  @contacts_hash = @contacts_selected if @contacts_selected.blank? == false
   	# mapped_contacts = @contacts_hash[parId]
      	#parId = "1:200037852"
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
         # @contacts_hash[parId]= read_from_array(resp_data_array)
         @contacts_hash[value]= resp_data_array
       else
          @contacts_hash[value]= [{"FirstName" => "No contacts available"}]
       end
        # store selected contacts just for checkboxes\
	     params[:accountPar] = nil
       session[:contacts_hash] = @contacts_hash
                        
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
	     # refresh all contacts and accounts selected by user
	     @contacts_selected = {}
	     @accounts_selected = []
       store_selected_contacts
       query_selected_fields(client)
      	# finds and inserts contacts for the accounts that were inserted
	     get_account_ids(@accounts_selected, client)
        p "selected account ",  session[:account_selected]
        p "selected contacts" , session[:contact_selected]
	     # reset session varaibles
        initialize_session_vars
	       # verify number of accounts updated and reroute
	      
	      redirect_post_commit
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
  
  def query_selected_fields(client)
   
    orgId = session[:orgId]
    query_selected = Selectedfield.find(:all, :select => "sfdcfield, parfield", :conditions => "orgid = '#{orgId}'")
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    @accounts_selected.each do |selected_par|
           upsertAccounts(selected_par, query_selected, theUrl, client)
    end
    
  end
 
  # This is a helper method for get_user_req to loop through multiple reqs
   def upsertAccounts(selected_par, query_selected, theUrl, client)
     p selected_par
     p query_selected
     
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
      # call insertsobject.rb to insert the mapped hashes into the S Object
      #InsertSObject.createclientobject(@mapped_hash, selected_par)
      Account.upsert("par121__parId__c", selected_par, @mapped_hash)
      p "account inserted"
  end
    
  def get_account_ids(par_id, client)
    par_id_string = par_id.map { |i| "'" + i + "'" }.join(",")
    par_id_string.gsub('"', "")
#    par_id_string = par_id.to_s.gsub!("[","'").gsub!("]","'")
    queryresp = client.query("SELECT PAR121__parId__c, id FROM Account where PAR121__parid__c in (#{par_id_string}) ")
    queryresp.each do |rec|
       @par_id_to_account_id_hash[rec["PAR121__parId__c"]] =  rec["Id"]
    end
    @contacts_selected = session[:contact_selected]
    insert_contact_details(@par_id_to_account_id_hash,@contacts_selected )
  end
  
  def insert_contact_details( accountId, contact_par)
        authenticateContact
        account_Id = ""
        contact_par.each do  |accountpar, contactpar| 
            contactpar.each do |contactId|
              theUrl = 'https://obo.par.se/itb/doc/ContactBlock.xml' 
              resp = self.class.get(theUrl, :query => {:contactId => contactId}).body
              doc=Nokogiri::XML(resp)
              p "reading xml"
              parfields = fieldstoinsert = Array.new

		    # must come from datbase
              fieldstoinsert = "Title", "PAR121__Status__c", "FirstName", "LastName", "Languages__c" 
              parfields = "ContactBlock/BlockCRMPosition/MainPosition/Text",  "ContactBlock/BlockBaseContact.parId", "ContactBlock/BlockBaseContact/FirstName","ContactBlock/BlockBaseContact/LastName", "ContactBlock/BlockBaseContact/Language/Text"
              fieldstoinsert.each_with_index do |field, ind|
                  parfield = parfields[ind]
                # fetch the value for the selected fields from the xml file
                  doc.xpath(parfield).each do |node|
                # @mapped_hash[sfdckey] = node.children.to_s 
                  node.children.to_s 
                  @contact_hash[field] = node.children.to_s
                end 
              end
 		# pick up the account Id from accountId parameter using accountpar
             account_Id = accountId[accountpar] 
            @contact_hash["AccountId"] = "#{account_Id}"
            Contact.upsert("par121__parId__c", "#{contactId}", @contact_hash)
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
        if @accounts_selected.length > 1
           uri = "https://" + uri.host + "/001/o"
       else
          uri = "https://" + uri.host + "/" +  @par_id_to_account_id_hash.values[0]
       end
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
#    session[:accountId] = "001U0000004byBE"
 #   @accounts_selected.push("1:200109878")
     @par_id_to_account_id_hash[params[:parId]] = session[:accountId]
    client = Databasedotcom:: Client.new #:client_id =>     "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret =>    "5686796735919094998", :debugging =>true
      #    client.authenticate :username => session[:sfdc_un], :password => session[:sfdc_pw]
        # session[:sid]= '00DU0000000ITUe!ASAAQDaRfoPHo8E4F_UuQsZAo6Z4LcIyS_S62qCNqfkuzmR2uKE5tGQ5Yb6FFDpFzhThO_b.HhMF3cGFEacyCe3fR5.vQafQ'
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    account_class = client.materialize("Account")
       # refresh all contacts and accounts selected by user
    query_selected_fields(client)
    redirect_post_commit
 end
end
