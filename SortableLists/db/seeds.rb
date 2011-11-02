# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Sfdctable.delete_all
sfdctable = Sfdctable.create(:fieldname => 'AccountNumber', :orgid =>'00DU0000', :fieldtype =>'String', :fieldlabel => 'Id')
sfdctable = Sfdctable.create(:fieldname => 'PAR121__Company_registration_number__c', :orgid =>'00DU0000', :fieldtype =>'String', :fieldlabel => "Company Number" )
sfdctable = Sfdctable.create(:fieldname => 'PAR121__StatusCode__c', :orgid =>'00DU0000', :fieldtype =>'String', :fieldlabel => "Status Code")

Pardb.delete_all
paruser = Pardb.create(:sfdc_id => '005U0000000Ymtl', :par_un => 'aviord4@utveckling', :par_pw => 'K5MeMmPP', :orgid =>'00DU0000000ITUe')
paruser = Pardb.create(:sfdc_id => '111111', :par_un => 'demo@par', :par_pw => 'K5MeMmPP', :orgid =>'1111')

Selectedfield.delete_all
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'00DU0000000ITUe')
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'00DU0000000ITUe')


selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'456')
selectedfield = Selectedfield.create(:parfield => 'WorksiteBlock/BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'456')

Partable.delete_all
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Status/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Country', :orgid => '00DU0000000ITUe')
partable  =Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/PostalAddress/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/VisitAddress/Address', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/VisitAddress/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/VisitAddress/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/VisitAddress/Country', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/Phone', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseCommunication/Fax', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMBusiness/MainBusiness/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMBusiness/MainBusiness/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMBusiness/Businesses/Business/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMBusiness/Businesses/Business/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/ShareCapital/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/ShareCapital/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/ShareCapital/Value', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/ShareCapital/Start', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/ShareCapital/End', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/Turnover/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/Turnover/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/Turnover/Value', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/Turnover/Start', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMEconomy/Turnover/End', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/Municipality/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/Municipality/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/County/Code', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/County/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/Country/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGeography/Country/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/OfficialWorksiteNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/WorksiteType/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/WorksiteType/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/VatNo', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/LegalName', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/LegalForm/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/LegalForm/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyType/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMOrganization/CompanyType/Text', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/NumberOfEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/NumberOfEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/NumberOfOfficeEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/NumberOfOfficeEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/CompanyNumberOfWorksites', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/CompanyNumberOfEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/CompanyNumberOfEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/CompanyNumberOfOfficeEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMSize/CompanyNumberOfOfficeEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGroup/CompanyDbId', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGroup/CompanyNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGroup/CompanyName', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockCRMGroup/Country', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockPlusCommunication/WWW', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite/Name', :orgid => '456')
partable = Partable.create(:fieldname => 'WorksiteBlock/BlockBaseWorksite.parId', :orgid => '456')
