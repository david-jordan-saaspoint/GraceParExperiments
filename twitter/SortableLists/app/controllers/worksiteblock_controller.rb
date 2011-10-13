  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  
class WorksiteblockController < ApplicationController
  include Databasedotcom::Rails::Controller 
  include HTTParty
  include Nokogiri
  
  before_filter :authentication_check
#  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  def authentication_check
    p "$$$$$ in authentication check of worksite controller $$$$$$$$$$$"
   self.class.basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  end
  
      #searches the database for data based on search criteria
  def find_by_wn
      @orgId = params[:orgId]
      wn = params[:worksite].capitalize
      wgc = params[:country].capitalize
      theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
      resp = self.class.get(theUrl, :query => {:worksiteName => wn, :worksiteGeneralCity => wgc})
      resp_hash = resp.parsed_response
      resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
      @mapped_data = Array.new
      @par_idset = Array.new
      counter =0
      resp_array = resp_data_array.each do |ele|  
        resp_array = ele
      # can we create this table here? 
        @par_idset << resp_array["parId"]
        @mapped_data[counter] =resp_array["Name"], resp_array["CompanyNumber"], resp_array["parId"]
        counter += 1
        end
    
   end 

    # checks for user requirement single or multiple
 def get_user_req
     orgId = params[:orgId]
 
     query_selected = Selectedfield.find(:all, :select => "sfdcField, parField", :conditions => "orgId = '#{orgId}'")
     theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
     if params[:id]
        user_choice = params[:id]
        selected_par = params[:par]
        upsert_record(selected_par, query_selected, theUrl)
     else
        mapped_data = params[:mapped_data]
        mapped_data.each do |rec|
          selected_par = rec
          upsert_record(selected_par, query_selected, theUrl)
        end
      end
  end
  
  # This is a helper method for get_user_req to loop through multiple reqs
   def upsert_record(selected_par, query_selected, theUrl)
     @mapped_hash = Hash.new
     resp = self.class.get(theUrl, :query => {:worksiteId => selected_par}).body
     xml_file = open("check.xml", 'w')
     xml_file.write(resp)
     xml_file.close
     xmlfile='check.xml'
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