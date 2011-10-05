require 'rubygems'
require 'httparty'
require_relative 'mapper'
require_relative 'insertsobject'
require 'sqlite3'
require_relative 'lookuptable'
require 'nokogiri'


# httparty call into PAR database
class CallbackWorksiteBlock1
  include HTTParty
  include Mapper
  include InsertSObject
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  
  
  def find_by_wsb(parId)
    
    result_array = Array.new
    mapped_hash= Hash.new
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    
    # selected_fields in a hash
    selected_fields = Hash.new
    selected_fields = {"Name" => "Name", "CompanyNumber" =>"AccountNumber", "parId" => "PAR121__parId__c"}
     
     
    resp = self.class.get(theUrl, :query => {:worksiteId => parId})
   
   #f= File.open(theUrl)
   #doc=Nokogiri::XML(f)
   # p doc
    resp_hash = resp.parsed_response
    
    # check the sqlite db for corresponding xml tag
    query_cond = selected_fields.values
   # query_cond ="('Name', 'AccountNumber')"
   
  #  query_cond.each do |cond|  
  #    p cond   
  db = SQLite3::Database.new("xmllookup.database")
     db.results_as_hash=true
   #  Xmltag.find_by_sql ["SELECT parfieldkey from xmltags where sfdckey in ('Name', 'AccountNumber')" ] do |row|
     db.execute("SELECT parfieldkey from xmltags where sfdckey in ('Name', 'AccountNumber')" ) do |row|
     query_result= row['parfieldkey'].split('/')
     x =  query_result.length
     query_result_array = Array.new
     query_result.each_slice(1)  do 
       |n| p n
       query_result_array << n
       p query_result_array
     end
         
   # p resp_data_name = resp_hash["#{query_result_array}"]      
     
   end
   db.close
   # p query_result_arr = query_result.split('/')
    
   # end
    
   # resp_data_array = resp_hash["WorksiteBlock"]["BlockBaseWorksite"]["Status"]
   aar1= ["WorksiteBlock"]
   aar2 = ["BlockBaseWorksite"]
   aar3=["Name"]
    resp_data_name = resp_hash
    resp_data_name
   
    resp_data_companynumber = resp_hash["WorksiteBlock"]["BlockCRMOrganization"]["CompanyNumber"]
    resp_data_companynumber
    # calls extract xml data method to extract the relevant fields from the output
    #extract_xml_data resp_data_array
    p result_array = resp_data_name, resp_data_companynumber, parId
    p "____________________________________________"
    p " Details of the company with ParId = #{parId}"
    #call mapper module to map the fileds to account sobject
    mapped_hash = Mapper.mapping_fields(result_array)
    
    # call insertsobject.rb to insert the mapped hashes into the S Object
   #  InsertSObject.createclientobject(mapped_hash, parId)
    
   end
end
callbackSecond = CallbackWorksiteBlock1.new
callbackSecond.find_by_wsb("1:201237946")
#callbackFirst.get_search_criteria
