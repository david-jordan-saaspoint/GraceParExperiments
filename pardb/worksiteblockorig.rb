require 'rubygems'
require 'httparty'
require_relative 'mapper'
require_relative 'insertsobject'
# httparty call into PAR database
class CallbackWorksiteBlock
  include HTTParty
  include Mapper
  include InsertSObject
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  
  
  def find_by_wsb(parId)
    
    result_array = Array.new
    mapped_hash= Hash.new
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    
     resp = self.class.get(theUrl, :query => {:worksiteId => parId}).body
     xml_file = open("check.xml", 'w')
     xml_file.write(resp)
     xml_file.close
     resp_hash = resp.parsed_response
     
    
   # resp_data_array = resp_hash["WorksiteBlock"]["BlockBaseWorksite"]["Status"]
    resp_data_name = resp_hash["WorksiteBlock"]["BlockBaseWorksite"]["Name"]
    resp_data_name
    resp_data_companynumber = resp_hash["WorksiteBlock"]["BlockCRMOrganization"]["CompanyNumber"]
    resp_data_companynumber
    # calls extract xml data method to extract the relevant fields from the output
    #extract_xml_data resp_data_array
    result_array = resp_data_name, resp_data_companynumber, parId
    p "____________________________________________"
    p " Details of the company with ParId = #{parId}"
    #call mapper module to map the fileds to account sobject
    mapped_hash = Mapper.mapping_fields(result_array)
    
    # call insertsobject.rb to insert the mapped hashes into the S Object
     InsertSObject.createclientobject(mapped_hash, parId)
    
   end
end
callbackSecond = CallbackWorksiteBlock.new
callbackSecond.find_by_wsb("1:201237946")
#callbackFirst.get_search_criteria
