require 'rubygems'
require 'active_record'


ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "selectedfields.database")

ActiveRecord::Schema.define do
   drop_table "selectedfields" 
   create_table :selectedfields do |table|
   
    table.column :parField, :string 
    table.column :sfdcField, :string
    table.column :orgId, :string
    end
  
end
class Selectedfield < ActiveRecord::Base
   
end

# populate the paruser table 
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcField => 'AccountNumber', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :sfdcField => 'PAR121__Status__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :sfdcField => 'PAR121__StatusCode__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcField => 'AccountNumber', :orgId =>'456')
### To output the data #####


#puts "________________________________________________________________________"

# p Selectedfield.find(:all)
#db = SQLite3::Database.new("selectedfields.database")
#    db.results_as_hash=true
#output = db.execute("select sfdcfield from selectedfields").flatten 
#p output[sfdcfield]

# Selectedfield.find(:all, :select => "id, sfdcfield")
#@output_array = Array.new
#@result_array = Selectedfield.find_by_sql("select id, sfdcfield from selectedfields")
#@result_array.each do |rec| 
#  @output_array.push("#{rec.sfdcField}") 
#end
#p @output_array
   
