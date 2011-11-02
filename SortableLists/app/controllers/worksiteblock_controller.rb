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
        session[:records] =3
        session[:criteria] = []
        
  end
  def paruser
      @mapped_country= Array.new
      session[:country].each do |rec| 
        @mapped_country.push(rec["description"])
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
    criteria
  end
     #searches the database for data based on search criteria
  def find_by_wn
      criteria = Hash.new
      criteria = search_criteria_populate 
      if  check_hash_empty?(criteria) == false
        initialize_session_vars
        theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
        resp = self.class.get(theUrl, :query => {:worksiteName => criteria["wn"], :worksiteGeneralCity => criteria["wgc"], :systemId => criteria["cny"], :worksiteGeneralAddress => criteria["add"], :worksitePostalZipCode => criteria["zp"], :phone => criteria["phn"], :groupNumber => criteria["gno"]})
        resp_hash = resp.parsed_response
        resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
        @mapped_data = read_from_array(resp_data_array) if resp_data_array.blank? == false
        session[:mapped_data] = @mapped_data
        @mapped_data = @mapped_data.paginate :page=>params[:page],  :per_page => 3
	       session[:records] = 3
        # @contacts_hash = @contacts_hash
	       criteria = {}
	       session[:flag] = "y"
      elsif session[:flag] == "y"
        show_contacts
      else
	     redirect_to worksiteblock_paruser_path
      end
   end
   def show_contacts
	   @mapped_data = session[:mapped_data] 
	   @mapped_data = @mapped_data.paginate :page=>params[:page] ,  :per_page => session[:records]
	   @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
     @criteria = session[:criteria]
  end
	
   def show_more_records
	    session[:records] = 8
      show_contacts
   end
   def show_more_details
	   show_contacts
   end
    def show_more_contactdetails
     show_contacts
   end
   def show_less_records
      session[:records] = 3
      show_contacts
   end

   def check_hash_empty?(criteria)
	    rtnval = true
	    criteria.each do |k,v| 
		    if v.blank? == false
			     @criteria.push(v) 
			     rtnval = false
		    else
		    end
	   end
	p   session[:criteria] = @criteria
	   return rtnval
   end 
   
   def get_contacts(parId)
      
	     @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
	 #  @contacts_hash = @contacts_selected if @contacts_selected.blank? == false
   	# mapped_contacts = @contacts_hash[parId]
      	#parId = "1:200037852"
       theUrl = 'https://obo.par.se/itb/doc/S-C-1.xml' 
       resp = self.class.get(theUrl, :query => {:worksiteId => parId})
       resp_hash = resp.parsed_response
       resp_data_array = resp_hash["S_C_1"]["ContactSearchResult1"]["Hit"]
       if resp_data_array.blank? == false
          @contacts_hash[parId]= read_from_array(resp_data_array)
       else
          @contacts_hash[parId]= [{"FirstName" => "No contacts available"}]
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
     
     if params[:par_contactset].blank? == false
          params[:par_contactset].each do  |contactpar|
              contactset = contactpar[1]
	            if  @accounts_selected.include?(contactset.split(" - ")[1])
  		            contactId = contactset.split(" - ")[0]
		              contactsArray.push(contactId)
	            else
		              if companyId.blank? == false
			            @contacts_selected[companyId] = contactsArray
			             contactsArray = []
		              end
		              companyId = contactset.split(" - ")[1]
		              @accounts_selected.push(companyId)
		              contactId = contactset.split(" - ")[0]
		              contactsArray.push(contactId)
	           end	
            end
	          @contacts_selected[companyId] = contactsArray
     end
       # updates selected account even if no contacts were selected
     verify_accounts_selected
     @accounts_selected.uniq
     session[:contact_selected]= @contacts_selected
	   session[:account_selected] = @accounts_selected
	   p	@contacts_selected
     p  @accounts_selected
 end
   
 def read_from_array(xmlarray)
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
     if params[:commit] == "Submit"   
       p "sdsadDA" 
       client = authenticate_account 
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
    
    else  # one of the show contacts button is pressed
       label = params[:commit]
       accountpar = label.split[2]
       store_selected_contacts
       get_contacts(accountpar)
        p @page = params[:page]
       @contacts_hash = session[:contacts_hash] 
       @mapped_data = session[:mapped_data]
       @criteria = session[:criteria]
  #        redirect_to(:controller => 'worksiteblock', :action => "find_by_wn")
    #
      redirect_to(:controller => 'worksiteblock', :action => "show_contacts")
     end
  end
  
  def authenticate_account
    client = Databasedotcom:: Client.new #:client_id =>     "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret =>    "5686796735919094998", :debugging =>true
      #    client.authenticate :username => session[:sfdc_un], :password => session[:sfdc_pw]
        # session[:sid]= '00DU0000000ITUe!ASAAQDaRfoPHo8E4F_UuQsZAo6Z4LcIyS_S62qCNqfkuzmR2uKE5tGQ5Yb6FFDpFzhThO_b.HhMF3cGFEacyCe3fR5.vQafQ'
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    account_class = client.materialize("Account")
    client
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
      respaccount = self.class.get(theUrl, :query => {:worksiteId => selected_par}).body
      doc=Nokogiri::XML(respaccount)
            query_selected.each do |field|
            query_result = field.parfield
            sfdckey = field.sfdcfield    
            # fetch the value for the selected fields from the xml file
            doc.xpath(query_result).each do |node|
              @mapped_hash[sfdckey] = node.children.to_s 
            end 
            
          end
      # call insertsobject.rb to insert the mapped hashes into the S Object
      #InsertSObject.createclientobject(@mapped_hash, selected_par)
      Account.upsert("par121__parId__c", "#{selected_par}", @mapped_hash)
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
        if @par_id_to_account_id_hash.length > 1
           uri = "https://" + uri.host + "/001/o"
       else
          uri = "https://" + uri.host + "/" + @par_id_to_account_id_hash.values[0]
       end
    redirect_to uri
  end
  

end
