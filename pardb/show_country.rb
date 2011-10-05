require 'rubygems'
require 'httparty'

class FirstStep
  include HTTParty
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  #initialize method is not presently used
  
  def dispcountry
    theUrl = 'http://obo.par.se/itb/doc/UserConfig.xml' 
  
    resp = self.class.get(theUrl)
    resp_hash = resp.parsed_response
    resp_data_array = resp_hash["UserConfig"]["conf"]["databases"]['database']
    
    # calls extract xml data method to extract the relevant fields from the output
    extract_xml_data resp_data_array
   end
   
   # extracts relevant data from the search output
   def extract_xml_data(resp_data_array)
      mapped_data = Array.new
      counter =0
      resp_array = resp_data_array.each do |ele|  
      resp_array = ele
      
      mapped_data[counter] = counter+1, resp_array["description"]
      counter += 1
     
      end
      p mapped_data
   end
end
#callbackFirst = FirstStep.new
# callbackFirst.find_by_wn("IKEA", "Stockholm")
#callbackFirst.dispcountry