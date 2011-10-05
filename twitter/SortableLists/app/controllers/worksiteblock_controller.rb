class WorksiteblockController < ApplicationController
   
  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'
  require 'insertsobject'

  include HTTParty
  include Nokogiri

  #@un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  #http_basic_authenticate_with :name => USER, :password => PASSWORD, :except => :index
  before_filter :authentication_check
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'

  def authentication_check
    authenticate_or_request_with_http_basic do |un,pw|
    @auth = {:username => @un, :password => @pw}
    basic_auth = @auth
    end  
  end
  
      #searches the database for data based on search criteria
  def find_by_wn
    
      wn = params[:worksite].capitalize
      wgc = params[:country].capitalize
      theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
      resp = self.class.get(theUrl, :query => {:worksiteName => wn, :worksiteGeneralCity => wgc})
      resp_hash = resp.parsed_response
      resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
      @mapped_data = Array.new
      counter =0
      resp_array = resp_data_array.each do |ele|  
        resp_array = ele
      # can we create this table here? 
        @mapped_data[counter] =resp_array["Name"], resp_array["CompanyNumber"], resp_array["parId"]
        counter += 1
        end
    
   end 


# Method not in use. Just for checking   
   def find_by_wsb
    parId= params[:par]
    result_array = Array.new
    mapped_hash= Hash.new
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    resp = self.class.get(theUrl, :query => {:worksiteId => parId})
    resp_hash = resp.parsed_response
   # resp_data_array = resp_hash["WorksiteBlock"]["BlockBaseWorksite"]["Status"]
    resp_data_name = resp_hash["WorksiteBlock"]["BlockBaseWorksite"]["Name"]
    resp_data_name
    resp_data_companynumber = resp_hash["WorksiteBlock"]["BlockCRMOrganization"]["CompanyNumber"]
    resp_data_companynumber
    # calls extract xml data method to extract the relevant fields from the output
    #extract_xml_data resp_data_array
    @result_array = resp_data_name, resp_data_companynumber, parId
       #call mapper module to map the fileds to account sobject
   # mapped_hash = Mapper.mapping_fields(result_array)
    
    # call insertsobject.rb to insert the mapped hashes into the S Object
    # InsertSObject.createclientobject(mapped_hash, parId)
  end

    # checks for user requirement
   def get_user_req
     user_choice = params[:id]
     selected_par = params[:par]
     @mapped_hash = Hash.new
     orgId= user_choice
     theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
     resp = self.class.get(theUrl, :query => {:worksiteId => selected_par}).body
     xml_file = open("check.xml", 'w')
     xml_file.write(resp)
     xml_file.close
     xmlfile='check.xml'
     f = File.read(xmlfile)
     doc=Nokogiri::XML(f)
     db = SQLite3::Database.new("selectedfield.database")
     db.results_as_hash=true
     #  Xmltag.find_by_sql ["SELECT parfieldkey from xmltags where sfdckey in ('Name', 'AccountNumber')" ] do |row|
     Selectedfield.find(:all) do |row|
     #db.execute("SELECT sfdcField, parField from Selectedfield where orgId = ? ", orgId) do |row|
        query_result= row['parField']
        sfdckey = row['sfdcField']
     
        # fetch the value for the selected fields from the xml file
        doc.xpath(query_result).each do |node|
            @mapped_hash[sfdckey] = node.children.to_s 
        end    
       end
      db.close
     # call insertsobject.rb to insert the mapped hashes into the S Object
     InsertSObject.createclientobject(@mapped_hash, selected_par)
   end


end
