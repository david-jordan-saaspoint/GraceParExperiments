 
 require 'rubygems'
require 'Databasedotcom'


    client = Databasedotcom:: Client.new :client_id =>"3MVG9QDx8IX8nP5SZh4eVqHyA0V.FsDc_RWvWL.6DUJVUrLLumMSOecJZ_1Io5y8Hs86kFXHYi9goW4Hycmof", :client_secret => "892547349198510318"
#   p client.authenticate :username => "grace@par-dev.com", :password => "Saaspoint12VmnWWoESfynbRW4RqG754SXD"
  p client.authenticate :token => "00DU0000000ITUe%21ASAAQP8S8wpwzTWHHeaR4CR6o80NyCM4ouvucATPM2uEEVcVpRMfstRrmKXZeY_hdpUHEleSzMODJMiNbjMzDShe3iA2.JDS", :instance_url => "https%3A%2F%2Fna12.salesforce.com%2Fservices%2FSoap%2Fc%2F22.0%2F00DU0000000ITUe"

  p client.username