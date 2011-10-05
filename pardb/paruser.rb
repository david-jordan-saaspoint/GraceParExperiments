require 'rubygems'
require 'active_record'


ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "paruserdb.database")

ActiveRecord::Schema.define do
   drop_table :parusers
   create_table :parusers do |table|
   
    table.column :sfdc_id, :string 
    table.column :par_un, :string
    table.column :par_pw, :string
    table.column :org_id, :string
   end
  
end
class Paruser < ActiveRecord::Base
   
end

# populate the paruser table 
paruser = Paruser.create(:sfdc_id => '005U0000000YmtlIAC', :par_un => 'aviord4@utveckling', :par_pw => 'K5MeMmPP', :org_id =>'1234')
paruser = Paruser.create(:sfdc_id => '111111', :par_un => 'demo@par', :par_pw => 'K5MeMmPP', :org_id =>'1111')

### To output the data #####


puts "________________________________________________________________________"
p Paruser.find(:all)
  
  


