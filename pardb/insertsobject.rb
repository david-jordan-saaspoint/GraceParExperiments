require 'rubygems'
require 'Databasedotcom'

# authenticate a client to work with salesforce
module InsertSObject
  def self.createclientobject(mapped_hash, parId)
    client = Databasedotcom:: Client.new :client_id =>"3MVG9QDx8IX8nP5SZh4eVqHyA0V.FsDc_RWvWL.6DUJVUrLLumMSOecJZ_1Io5y8Hs86kFXHYi9goW4Hycmof", :client_secret => "892547349198510318"
   p client.authenticate :username => "grace@par-dev.com", :password => "Saaspoint12VmnWWoESfynbRW4RqG754SXD"
#  p client.authenticate :token => "000DU0000000ITUe%21ASAAQDUiJoj77oqcvEIQxp9dNdnIh5JD_63K41lY75UeLuUQR2f_v6UqHCeobN.uBmDkEP9HQvILbBeZiqNud70T3MBy9TDo", :instance_url => "https://na12.salesforce.com%2Fservices%2FSoap%2Fc%2F22.0%2F00DU0000000ITUe"
# p client.authenticate :token => "00DU0000000ITUe%21ASAAQP8S8wpwzTWHHeaR4CR6o80NyCM4ouvucATPM2uEEVcVpRMfstRrmKXZeY_hdpUHEleSzMODJMiNbjMzDShe3iA2.JDS", :instance_url => "https%3A%2F%2Fna12.salesforce.com%2Fservices%2FSoap%2Fc%2F22.0%2F00DU0000000ITUe"


 # p client
    InsertSObject.writesobject(client, mapped_hash, parId)
  end
  
  def self.writesobject(client,mapped_hash, parId)
    begin
      account_class = client.materialize("Account")
    # write a new account with the details
      accounthash = Hash.new
      accounthash['Name']= mapped_hash['Name']
      accounthash['AccountNumber'] = mapped_hash['AccountNumber']
      client.upsert(Account, "par121__parId__c", "#{parId}", accounthash)
     # client.upsert(Account, "par121__parId__c", "01-09898", accounthash) 
     rescue Exception
       p "error #{$!}"
       p "could not upsert record for #{parId}"
     end
  end
end

#newInsertObject = InsertSObject.new
#newInsertObject.createclientobject