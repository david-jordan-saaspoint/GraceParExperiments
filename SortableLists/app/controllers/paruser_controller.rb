require 'rubygems'
require 'httparty'

require 'open-uri'
class ParuserController < ApplicationController
  include Databasedotcom::Rails::Controller
  include HTTParty
  include Nokogiri
  format :xml
  
  
  before_filter :authentication_check
  
   
  
#  @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  def authentication_check
    @un = session[:un]
    @pw = session[:pw]
    p "$$$$$ in authentication check of paruser controller $$$$$$$$$$$"
    self.class.basic_auth @un, @pw
  end
  
  
  def dispcountry
    @authentication = params[:authentication]
    theUrl = 'http://obo.par.se/itb/doc/UserConfig.xml' 
    resp = self.class.get(theUrl)
    resp_hash = resp.parsed_response
    @mapped_country = resp_hash["UserConfig"]["conf"]["databases"]['database']
#    @mapped_country = Array.new
#    counter =0
 #   resp_array = resp_data_array.each do |ele|  
  #    resp_array = ele
 #     @mapped_country[counter] = resp_array["description"]
  #    counter += 1
   # end
     session[:country] = @mapped_country
  end
  
end
