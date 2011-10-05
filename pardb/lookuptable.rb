require 'rubygems'
require 'active_record'


ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "xmllookup.database")

ActiveRecord::Schema.define do
   drop_table "xmltags" 
   create_table :xmltags do |table|
   
    table.column :parfieldkey, :string 
    table.column :sfdckey, :string
    end
  
end
class Xmltag < ActiveRecord::Base
   
end

# populate the paruser table 
xmltag = Xmltag.create(:parfieldkey => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdckey => 'Name')
xmltag = Xmltag.create(:parfieldkey => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdckey => 'PAR121__parId__c')
xmltag = Xmltag.create(:parfieldkey => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdckey => 'AccountNumber')
xmltag = Xmltag.create(:parfieldkey => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :sfdckey => 'PAR121__Status__c')
xmltag = Xmltag.create(:parfieldkey => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :sfdckey => 'PAR121__StatusCode__c')

### To output the data #####


#puts "________________________________________________________________________"
#p Xmltag.find(:all)
  