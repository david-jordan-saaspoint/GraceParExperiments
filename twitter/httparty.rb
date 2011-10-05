require 'rubygems'
require 'httparty'

# httparty call into PAR database
class Callback
  include HTTParty
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  def initialize(u, p)
    @auth = {:username => u, :password => p}
    basic_auth = @auth
  end
  
  # accepts user input for search criteria
  def get_search_criteria
    wgc = wn = ""
    
    puts " Enter WorkSite Name: "
    wn = gets.chomp.capitalize
    puts "Enter Worksite City: "
    wgc = gets.chomp.capitalize
    
    # calls the find method to get output records based on the input criteria
    find_by_wn(wn,wgc)
  end
  
  #searches the database for data based on search criteria
  def find_by_wn(wn,wgc)
   
    theUrl = 'https://obo.par.se/itb/doc/S-W-4.xml' 
    
    resp = self.class.get(theUrl, :query => {:worksiteName => wn, :worksiteGeneralCity => wgc})
    resp_hash = resp.parsed_response
    resp_data_array = resp_hash["S_W_4"]["WorksiteSearchResult"]["Hit"]
    
    # calls extract xml data method to extract the relevant fields from the output
    extract_xml_data resp_data_array
   end
   
   # extracts relevant data from the search output
   def extract_xml_data(resp_data_array)
      mapped_data = Array.new
      counter =0
      resp_array = resp_data_array.each do |ele|  
      resp_array = ele
      
      mapped_data[counter] = counter+1, resp_array["Name"], resp_array["CompanyNumber"], resp_array["parId"]
      counter += 1
      #resp_array.each do |attr,value|
        #v_attr = "#{attr}"
        #p v_attr
        #if v_attr == "Name" || v_attr == "CompanyNumber" || v_attr == "parId"
         # p "#{attr}: #{value}"
         # mapped_data[attr] = value
          
        #end
        #mapped_data.each {|ele| p ele}
      #end 
    end 
    
    # calls user requirement method to ask for user choice of records
    get_user_requirement(mapped_data, counter)
   end 
    # checks for user requirement
   def get_user_requirement(mapped_data, counter)
    user_choice = 0
    mapped_data.each {|ele| p ele}
    puts "Please enter your choice (between 1 and #{counter}): "
    user_choice = gets.to_i
    
    p mapped_data[user_choice-1]
    
    # calls the method to write the selected data to local database
   end
end
callbackFirst = Callback.new('aviord4@utveckling', 'K5MeMmPP')
# callbackFirst.find_by_wn("IKEA", "Stockholm")
callbackFirst.get_search_criteria


 