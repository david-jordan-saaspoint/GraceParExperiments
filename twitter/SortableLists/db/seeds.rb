# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Sfdctable.delete_all


sfdctable = Sfdctable.create(:fieldname => 'AccountNumber', :orgId =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => 'Id')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__Company_registration_number__c', :orgId =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => "Company Number" )
sfdctable = Sfdctable.create(:fieldname => 'PAR121__StatusCode__c', :orgId =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => "Status Code")

Pardb.delete_all
paruser = Pardb.create(:sfdc_id => '005U0000000YmtlIAC', :par_un => 'aviord4@utveckling', :par_pw => 'K5MeMmPP', :orgId =>'00DU0000000ITUe')
paruser = Pardb.create(:sfdc_id => '111111', :par_un => 'demo@par', :par_pw => 'K5MeMmPP', :orgId =>'1111')

Selectedfield.delete_all
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'00DU0000000ITUe')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'00DU0000000ITUe')


selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcField => 'Name', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcField => 'PAR121__parId__c', :orgId =>'456')
selectedfield = Selectedfield.create(:parField => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcField => 'AccountNumber', :orgId =>'456')

Partable.delete_all
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgId => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :orgId => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Country', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Address', :orgId => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Zipcode', :orgId => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/City', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/BlockBaseCommunication/Phone', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/BlockBaseCommunication/City', :orgId => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :orgId => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyType/Code', :orgId => '00DU0000000ITUe')

partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgId => '456')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgId => '456')