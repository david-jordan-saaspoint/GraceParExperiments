# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

sfdctable = Sfdctable.create(:fieldname => 'Name', :orgId => '123', :fieldtpe =>'String')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__parId__c', :orgId => '123', :fieldtpe =>'String')

sfdctable = Sfdctable.create(:fieldname => 'AccountNumber', :orgId =>'123', :fieldtpe =>'String')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__Status__c', :orgId =>'123', :fieldtpe =>'String')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__StatusCode__c', :orgId =>'123', :fieldtpe =>'String')

paruser = Pardb.create(:sfdc_id => '005U0000000YmtlIAC', :par_un => 'aviord4@utveckling', :par_pw => 'K5MeMmPP', :orgId =>'1234')
paruser = Pardb.create(:sfdc_id => '111111', :par_un => 'demo@par', :par_pw => 'K5MeMmPP', :orgId =>'1111')


selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcField => 'AccountNumber', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :sfdcField => 'PAR121__Status__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :sfdcField => 'PAR121__StatusCode__c', :orgId =>'123')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcField => 'AccountNumber', :orgId =>'456')