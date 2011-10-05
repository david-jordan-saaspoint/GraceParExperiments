require 'rubygems'
require 'httparty'


class ABC
  include HTTParty
  format :json

  
  
  def self.get_all
    base_uri ='http://api.twitter.com/1/trends.json'
    get(base_uri)
    #url = 'https://obo.par.se'

  end
end

p ABC.get_all

