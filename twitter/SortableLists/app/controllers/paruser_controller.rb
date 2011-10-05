require 'rubygems'
require 'httparty'

require 'open-uri'
class ParuserController < ApplicationController
  include HTTParty
  include Nokogiri
  format :xml

 # @un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  #http_basic_authenticate_with :name => USER, :password => PASSWORD, :except => :index
  before_filter :authentication_check
  basic_auth 'aviord4@utveckling', 'K5MeMmPP'

  def authentication_check
    authenticate_or_request_with_http_basic do |un,pw|
    @auth = {:username => @un, :password => @pw}
    basic_auth = @auth
    end  
  end
  def dispcountry
    theUrl = 'http://obo.par.se/itb/doc/UserConfig.xml' 
    resp = self.class.get(theUrl)
    resp_hash = resp.parsed_response
    resp_data_array = resp_hash["UserConfig"]["conf"]["databases"]['database']
    @mapped_data = Array.new
    counter =0
    resp_array = resp_data_array.each do |ele|  
      resp_array = ele
      @mapped_data[counter] = resp_array["description"]
      counter += 1
    end
  end
  
end
