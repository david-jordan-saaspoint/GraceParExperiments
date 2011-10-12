require 'rubygems'
require 'httparty'
require_relative 'worksiteblock'
require_relative'show_country'

# httparty call into PAR database
class CallbackRestsc4
  
  include HTTParty
  format :xml
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'
  
  #initialize method is not presently used
  def initialize(u,p)
    @auth = {:username => u, :password => p}
    basic_auth = @auth
    @orgId= "123"
  end
  
  # accepts user input for search criteria
  def get_search_criteria
  # display the countries first
    p "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    p " Countries you have subscribed to are:"

    callbackFirst = FirstStep.new
    callbackFirst.dispcountry
    wgc = wn = ""
    puts "__________________________________________"
    puts "\nEnter the Worksite Name and WorkSite City for Par DB search"
    puts "\n Enter WorkSite Name: "
    wn = gets.chomp.capitalize
    puts "\nEnter Worksite City: "
    wgc = gets.chomp.capitalize
    
    # calls the find method to get output records based on the input criteria
    if wgc =="" || wn == ""
      puts " You must enter a worksite name and city"
    else
      
      # need to add a validity check for  list of city and worksite name
      find_by_wn(wn,wgc)
    end
    
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
    selected_array = Array.new
    if user_choice > counter
      puts "Enter valid number"
    else
      p selected_array =  mapped_data[user_choice-1]
       p selected_array[3]
       
      
      # calls worksiteblock to look for further details by creating a new object
       worksiteblockobject = CallbackWorksiteBlock.new
       worksiteblockobject.find_by_wsb("#{selected_array[3]}", @orgId)
    end
    
    
   end
end
callbackFirst = CallbackRestsc4.new('aviord4@utveckling', 'K5MeMmPP')
# callbackFirst.find_by_wn("IKEA", "Stockholm")
callbackFirst.get_search_criteria




 