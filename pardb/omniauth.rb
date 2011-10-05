require 'rubygems'
require 'Databasedotcom'

# authenticate a client to work with salesforce

client = Databasedotcom:: Client.new :client_id => "3MVG9QDx8IX8nP5SZh4eVqHyA0V.FsDc_RWvWL.6DUJVUrLLumMSOecJZ_1Io5y8Hs86kFXHYi9goW4Hycmof", :client_secret => "892547349198510318"
client.authenticate :username => "grace@par-dev.com", :password => "Saaspoint12VmnWWoESfynbRW4RqG754SXD"

account_class = client.materialize("Account")
 Account.find_by_Name("GenePoint")
  p client.client_id
#  client.debugging = true

# write a new account with the details

  account = Account.new
  account.Name = 'ABCxxrr'
  account.AccountNumber = '123499 TEST UPSERT'
  account.PAR121__parId__c = '01-09898'
  account.OwnerId = client.user_id
  account.PAR121__Subscribed__c = true

begin
#p account.save
client.upsert(Account, "par121__parId__c", "01-09898", {"Name" => "ABCxxrr"})

rescue
   p "error #{$!}"
   p "Could not insert record for"
end


