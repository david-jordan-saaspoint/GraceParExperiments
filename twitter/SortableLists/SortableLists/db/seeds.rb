# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Sfdctable.delete_all


sfdctable = Sfdctable.create(:fieldname => 'AccountNumber', :orgid =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => 'Id')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__Company_registration_number__c', :orgid =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => "Company Number" )
sfdctable = Sfdctable.create(:fieldname => 'PAR121__StatusCode__c', :orgid =>'00DU0000000ITUe', :fieldtype =>'String', :fieldlabel => "Status Code")

Pardb.delete_all
paruser = Pardb.create(:sfdc_id => '005U0000000Ymtl', :par_un => 'aviord4@utveckling', :par_pw => 'K5MeMmPP', :orgid =>'00DU0000000ITUe')
paruser = Pardb.create(:sfdc_id => '111111', :par_un => 'demo@par', :par_pw => 'K5MeMmPP', :orgid =>'1111')

Selectedfield.delete_all
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'00DU0000000ITUe')
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'00DU0000000ITUe')


selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'456')
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'456')
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :sfdcfield => 'AccountNumber', :orgid =>'456')

Partable.delete_all
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgid => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :orgid => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Country', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Address', :orgid => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Zipcode', :orgid => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/BlockBaseCommunication/Phone', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/BlockBaseCommunication/City', :orgid => '00DU0000000ITUe')
partable =Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyType/Code', :orgid => '00DU0000000ITUe')

partable =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgid => '456')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgid => '456')