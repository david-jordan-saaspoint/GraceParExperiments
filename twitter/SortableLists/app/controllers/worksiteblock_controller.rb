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
#  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  def authentication_check
     p "$$$$$ in authentication check of worksite controller $$$$$$$$$$$"
     @un = session[:un]
     @pw = session[:pw]
     self.class.basic_auth @un, @pw
  end
  
      #searches the database for data based on search criteria
  def find_by_wn
    
    if params[:par]
       @mapped_contacts = get_contacts(params[:par])
      # @mapped_data = params[:data]
     
        @mapped_data = session[:mapped_data]
        @mapped_contacts
    else
      @mapped_data = Array.new
      wn = params[:worksite].capitalize
      wgc = params[:country].capitalize
      theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
      resp = self.class.get(theUrl, :query => {:worksiteName => wn, :worksiteGeneralCity => wgc})
      resp_hash = resp.parsed_response
      resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
      @mapped_data = read_from_array(resp_data_array)
      session[:mapped_data] = @mapped_data
      @mapped_data
     end   
   end 
   
   def get_contacts(parId)
      
 #     parId = "1:200037852"
      theUrl = 'https://obo.par.se/itb/doc/S-C-1.xml' 
      resp = self.class.get(theUrl, :query => {:worksiteId => parId})
      resp_hash = resp.parsed_response
      resp_data_array = resp_hash["S_C_1"]["ContactSearchResult1"]["Hit"]
      mapped_contacts = Array.new
      mapped_contacts = read_from_array(resp_data_array)
      
   end
   
   def read_from_array(xmlarray)
     counter =0
     mapped_contacts = Array.new
      xmlarray.each do |ele|
          if ele.class ==Hash
            resp_array = ele
          # can we create this table here? 
            mapped_contacts[counter] =resp_array
            counter += 1
          else
            resp_array = xmlarray
            mapped_contacts[counter] =resp_array
          end  
         end
         mapped_contacts
   end

    # checks for user requirement single or multiple
 def get_user_req
   if params[:par_contactset]
        contact_par = params[:par_contactset]
        companyId= session[:companyId]
        find_contact_details(contact_par, companyId)
   end
    if params[:par_idset]   
      @inserted_records = Array.new
      @mapped_hash= Hash.new
      client = Databasedotcom:: Client.new #:client_id => "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret => "5686796735919094998", :debugging =>true
  #    client.authenticate :username => session[:sfdc_un], :password => session[:sfdc_pw]
    # session[:sid]= '00DU0000000ITUe!ASAAQDaRfoPHo8E4F_UuQsZAo6Z4LcIyS_S62qCNqfkuzmR2uKE5tGQ5Yb6FFDpFzhThO_b.HhMF3cGFEacyCe3fR5.vQafQ'
      client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
  #   p client
      account_class = client.materialize("Account")
      orgId = session[:orgId]
      @par_idset = params[:par_idset]
      query_selected = Selectedfield.find(:all, :select => "sfdcField, parField", :conditions => "orgId = '#{orgId}'")
      theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
      @par_idset.each do |rec|
          selected_par = rec[1]
          upsertAccounts(selected_par, query_selected, theUrl)
      end
    end
     
  end
    
  def find_contact_details(contact_par, accountId)
        authenticateContact
        contact_par.each do  |contactpar| 
        contactId = contactpar[1] 
        @contact_hash = Hash.new
        theUrl = 'https://obo.par.se/itb/doc/ContactBlock.xml' 
        resp = self.class.get(theUrl, :query => {:contactId => contactId}).body
        xml_file = open("contact.xml", 'w')
        xml_file.write(resp)
        xml_file.close
        xmlfile='contact.xml'
        f = File.read(xmlfile)
        doc=Nokogiri::XML(f)
        p "reading xml"
        parfields = fieldstoinsert = Array.new
        fieldstoinsert = "Title", "PAR121__Status__c", "FirstName", "LastName", "Languages__c" 
        parfields = "ContactBlock/BlockCRMPosition/MainPosition/Text", "ContactBlock/BlockBaseContact/Status/Text", "ContactBlock/BlockBaseContact.parId", "ContactBlock/BlockBaseContact/FirstName","ContactBlock/BlockBaseContact/LastName", "ContactBlock/BlockBaseContact/Language/Text"
        fieldstoinsert.each_with_index do |field, ind|
            parfield = parfields[ind]
             # fetch the value for the selected fields from the xml file
            doc.xpath(parfield).each do |node|
             # @mapped_hash[sfdckey] = node.children.to_s 
             p node.children.to_s 
             @contact_hash[field] = node.children.to_s
            end 
           
         end
 #       @contact_hash["AccountId"] = "#{accountId}"
        Contact.upsert("par121__parId__c", "#{contactId}", @contact_hash)
     end
      #resp_hash = resp.parsed_response
      #resp_data_array = resp_hash["ContactBlock"]["BlockBaseContact"]
      #mapped_contacts = Array.new
      #mapped_contacts = read_from_array(resp_data_array)
      #p mapped_contacts
  end
  def authenticateContact
    client = Databasedotcom:: Client.new #:client_id => "3MVG9QDx8IX8nP5SZh4eVqHyA0S7c4fHJn0F6fceNVYsECfC.3JP0g2WWZwcL_uXNL0COFbFuOndmT1aXi_oj", :client_secret => "5686796735919094998", :debugging =>true
    client.authenticate(:options => nil, :token => session[:sid], :instance_url => session[:uri])
    account_class = client.materialize("Contact")
    orgId = session[:orgId]
  end
  
  # This is a helper method for get_user_req to loop through multiple reqs
   def upsertAccounts(selected_par, query_selected, theUrl)
     @inserted_records << selected_par 
     
     resp = self.class.get(theUrl, :query => {:worksiteId => selected_par}).body
     xml_file = open("accounts.xml", 'w')
     xml_file.write(resp)
     xml_file.close
     xmlfile='accounts.xml'
     f = File.read(xmlfile)
     doc=Nokogiri::XML(f)
        
          query_selected.each do |field|
            query_result = field.parField
            sfdckey = field.sfdcField    
            # fetch the value for the selected fields from the xml file
            doc.xpath(query_result).each do |node|
              @mapped_hash[sfdckey] = node.children.to_s 
            end 
            
          end
     # call insertsobject.rb to insert the mapped hashes into the S Object
     #InsertSObject.createclientobject(@mapped_hash, selected_par)
     
     Account.upsert("par121__parId__c", "#{selected_par}", @mapped_hash)
   end


end