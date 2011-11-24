class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :establish_connection
  cattr_accessor :client

  def establish_connection
    return unless session[:auth]
    begin
      STDOUT.puts "establish connection to database.com"
       p "uri", session[:uri]
    p "token", session[:token]
    p "---"
    @client = Databasedotcom::Client.new
    @client.authenticate :token => session[:token], :instance_url =>session[:uri] 
      #check connection w. list_sobjects and cache result
      self.class.client = @client
      sobjects
      STDOUT.puts "connection established"
    rescue Databasedotcom::SalesForceError => e
      #should retry with refresh_token
      STDOUT.puts "caught #{e.message} \n\n #{e.backtrace}"
      session[:auth] = false
      redirect_to '/'
    end
  end

  def protect!
    return if logged_in?
    redirect_to :controller => "sessions", :action => 'new'
  end

  def logged_in?
    session[:auth]
  end

  def client
    self.class.client
  end

  def self.sobjects
    @sobjects ||= self.client.list_sobjects
  end

  def sobjects
    self.class.sobjects
  end

  def self.const_missing(sym)
    custom_obj = sym.to_s + '__c'
    if sobjects.include?(custom_obj)
      client.materialize(custom_obj)
    elsif sobjects.include? sym.to_s
      client.materialize(sym.to_s)
    else
      super
    end
  end
end

