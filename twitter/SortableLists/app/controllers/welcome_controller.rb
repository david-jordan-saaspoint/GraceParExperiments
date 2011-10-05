require 'rubygems'
require 'httparty'

require 'open-uri'
class WelcomeController < ApplicationController
  
 include HTTParty
 #This has to be from the sessions data
  #@un, @pw = 'aviord4@utveckling', 'K5MeMmPP'
  #http_basic_authenticate_with :name => USER, :password => PASSWORD, :except => :index
  before_filter :authentication_check
  
   def authentication_check
    authenticate_or_request_with_http_basic do |un,pw|
    @auth = {:username => @un, :password => @pw}
    basic_auth = @auth
    end  
  end
  
  def index
     # this needs to come from sessions details in html header
     @message = params[:sfdcid]
     
  end
  
  def paruser
      @pardb = Pardb.find(params[:id])
      @un = @pardb.par_un
      @pw = @pardb.par_pw
  end
   
  
  def fieldlist
      @fieldlist = Array.new
      @sfdctables = Sfdctable.all
      @sfdctables.each do |sfdctable| 
        @fieldlist.push(sfdctable.fieldname)
      end
      # @fieldlist= Sfdctable.find(:all, :select => "fieldname")
      # @fieldlist = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StatusCode__c"]
  end
     
end
