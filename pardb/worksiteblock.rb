require 'rubygems'
require 'httparty'
require_relative 'mapper'
require_relative 'insertsobject'
require 'sqlite3'
require_relative 'lookuptable'
require_relative 'selectedfields'
require 'nokogiri'
require 'open-uri'


# httparty call into PAR database
class CallbackWorksiteBlock
  include HTTParty
  include Mapper
  include InsertSObject
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  
  
  def find_by_wsb(parId, orgId)
    mapped_hash= Hash.new
    theUrl = 'https://obo.par.se/itb/doc/WorksiteBlock.xml' 
    resp = self.class.get(theUrl, :query => {:worksiteId => parId}).body
     xml_file = open("check.xml", 'w')
     xml_file.write(resp)
     xml_file.close
    # selected_fields in a hash
    #selected_fields = Hash.new
    #selected_fields = {"Name" => "Name", "CompanyNumber" =>"AccountNumber", "parId" => "PAR121__parId__c"}
     
     
    #resp = self.class.get(theUrl, :query => {:worksiteId => parId})
    # read the xml file  NEEDS TO Be DYNAMIC $$$$$$$$$$$$$$$$$$$$$$$$$
    # $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    xx='check.xml'
    f= File.read(xx)
    doc=Nokogiri::XML(f)
   #  doc = Nokogiri::XML(open("https://obo.par.se/itb/doc/WorksiteBlock.xml"))      
    # check the sqlite db for corresponding xml tag
       
    db = SQLite3::Database.new("selectedfields.database")
    db.results_as_hash=true
    
   #  Xmltag.find_by_sql ["SELECT parfieldkey from xmltags where sfdckey in ('Name', 'AccountNumber')" ] do |row|
    db.execute("SELECT sfdcField, parField from selectedfields where orgId = ? ", orgId) do |row|
      p query_result= row['parField']
      p sfdckey = row['sfdcField']
 
   
     # fetch the value for the selected fields from the xml file
      doc.xpath(query_result).each do |node|
      mapped_hash[sfdckey] = node.children.to_s 
      end    
     
    end
    db.close
    
    p "____________________________________________"
    p " Details of the company with ParId = #{parId}"
    #call mapper module to map the fileds to account sobject
   # mapped_hash = Mapper.mapping_fields(result_array)
     p mapped_hash
    # call insertsobject.rb to insert the mapped hashes into the S Object
     InsertSObject.createclientobject(mapped_hash, parId)
   
   end
end
#callbackSecond = CallbackWorksiteBlock.new
#callbackSecond.find_by_wsb("1:200686583", "123")
#callbackFirst.get_search_criteria
