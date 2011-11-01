  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  require 'databasedotcom'
  
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
    @inserted_records = Array.new
    @mapped_hash= Hash.new
    @contact_hash = Hash.new
    @accounts_contacts = Array.new
    @par_id_to_account_id_hash = Hash.new
  end
#  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  def authentication_check
     p "$$$$$ in authentication check of worksite controller $$$$$$$$$$$"
     @un = session[:un]
     @pw = session[:pw]
     self.class.basic_auth @un, @pw
  end
     #searches the database for data based on search criteria
  def find_by_wn
    if  params[:worksite]
        wn = params[:worksite].capitalize
        wgc = params[:country].capitalize
        # initialize all session parameters for this task
        session[:account_selected]= []
        session[:contact_selected] = {}
        session[:contacts_hash]= []
        session[:select] = "N"
        theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
        resp = self.class.get(theUrl, :query => {:worksiteName => wn, :worksiteGeneralCity => wgc})
        resp_hash = resp.parsed_response
        resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
        @mapped_data = read_from_array(resp_data_array)
        session[:mapped_data] = @mapped_data
        @mapped_data
        @contacts_hash
    elsif params[:select] == 'Y' 
        session[:accountPar] = nil
        @mapped_data = session[:mapped_data]
        @contacts_hash = session[:contacts_hash]
        
    else 
        @mapped_data = session[:mapped_data]
        @contacts_hash = session[:contacts_hash]
     end   
    
   end 
   
   def get_contacts(parId)
       p "gettting contacts"
       p parId
        @contacts_hash = session[:contacts_hash] if session[:contacts_hash].blank? == false
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
        p params[:par_contactset]
              
   end
   def store_selected_contacts
     p "store_selected_contacts"
     p params[:par_contactset]
     companyId = ""
     if params[:par_contactset].blank? == false
          contactsArray = Array.new
          p  contact_par = params[:par_contactset]
          companyId = ""
          contact_par.each do  |contactpar|
            contactset = contactpar[1]
            if companyId.blank? ==false or contactset.split["-"][0] == companyId
              
              contactId = contactset.split["-"][1]
              #@contacts_selected.push(contactId)
              contactsArray.push(contactId)
            else
              @contacts_selected["#{companyId}"] = contactsArray
              @accounts_selected.push(companyId)
              @contacts_selected
              @accounts_selected
              session[:contact_selected]= @contacts_selected
              companyId = contactset.split["-"][0]
              contactId = contactset.split["-"][1]
              contactsArray.push(contactId)
           end
          end
      end
   end
   
   def read_from_array(xmlarray)
     counter =0
     mapped_data = Array.new
      xmlarray.each do |ele|
          if ele.class ==Hash
            resp_array = ele
          # can we create this table here? 
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
    @contacts_selected = session[:contact_selected]
    @accounts_selected = session[:account_selected]
     if params[:commit] == "Submit"    
        client = Databasedotcom:: Client.new #:client_id => "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret => "5686796735919094998", :debugging =>true
    #    client.authenticate :username => session[:sfdc_un], :password => session[:sfdc_pw]
      # session[:sid]= '00DU0000000ITUe!ASAAQDaRfoPHo8E4F_UuQsZAo6Z4LcIyS_S62qCNqfkuzmR2uKE5tGQ5Yb6FFDpFzhThO_b.HhMF3cGFEacyCe3fR5.vQafQ'
        client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
  #     p client
        account_class = client.materialize("Account")
        orgId = session[:orgId]
        @par_idset = params[:par_idset]
        p @par_idset
      # @par_idset = @accounts_selected
        query_selected = Selectedfield.find(:all, :select => "sfdcfield, parfield", :conditions => "orgid = '#{orgId}'")
        theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
        @par_idset.each do |selected_par|
           upsertAccounts(selected_par[1], query_selected, theUrl, client)
            @accounts_selected.push(selected_par[1])
          #   session[:account_selected]= @accounts_selected.uniq
        end
      # finds and inserts contacts for the accounts that were inserted
        if params[:par_contactset].blank? == false
            contactsArray = Array.new
            p  contact_par = params[:par_contactset]
          #      p  find_contact_details(contact_par, companyId)
            companyId = ""
            contact_par.each do  |contactpar|
              contactset = contactpar[1]
              if companyId.blank? or contactset.split["-"][0] == companyId
                companyId = contactset.split["-"][0]
                contactId = contactset.split["-"][1]
              #@contacts_selected.push(contactId)
                contactsArray.push(contactId)
              else
                @contacts_selected["#{companyId}"] = contactsArray
                @contacts_selected
                session[:contact_selected]= @contacts_selected
              end
              get_account_ids(@accounts_selected, client)
            end
        end
  
        session[:select] = 'Y'
        p "selected account ",  session[:account_selected]
        p "selected contacts" , session[:contact_selected]
        redirect_to(:controller => 'worksiteblock', :action => "find_by_wn")
        else  # one of the show contacts button is pressed
          accountpar =""
          p label = params[:commit]
          accountpar = label.split[2]
          store_selected_contacts
          
          get_contacts(accountpar)
          # @mapped_data = params[:data]
          @contacts_hash = session[:contacts_hash]
          @mapped_data = session[:mapped_data]
          redirect_to(:controller => 'worksiteblock', :action => "find_by_wn")
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
    
        
     # reset session varaibles
 #    session[:account_selected] = nil
  #   session[:contact_selected] = nil
  #   session[:companyId] = nil
  #   session[:mapped_data] = nil
  #   session[:select] = nil
   end
    
  def get_account_ids(par_id, client)
    
    par_id_string = par_id.map { |i| "'" + i + "'" }.join(",")
    par_id_string.gsub('"', "")
#    par_id_string = par_id.to_s.gsub!("[","'").gsub!("]","'")
    
    queryresp = client.query("SELECT PAR121__parId__c, id FROM Account where PAR121__parid__c in (#{par_id_string}) ")
    queryresp.each do |rec|
      @par_id_to_account_id_hash[rec["PAR121__parId__c"]] =  rec["Id"]
     end
    
     @par_id_to_account_id_hash
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
         # pick up the account Id from accountId parameter using accountpar
       
         end
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
  

end