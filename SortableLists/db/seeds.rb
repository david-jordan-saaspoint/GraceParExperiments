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
selectedfield = Selectedfield.create(:parfield => 'BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'00DU0000000ITUe')
selectedfield = Selectedfield.create(:parfield => 'BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'00DU0000000ITUe')


selectedfield = Selectedfield.create(:parfield => 'BlockBaseWorksite/Name', :sfdcfield => 'Name', :orgid =>'456')
selectedfield = Selectedfield.create(:parfield => 'BlockBaseWorksite.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'456')

Partable.delete_all
partable = Partable.create(:fieldname => 'BlockBaseWorksite/Name', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseWorksite.parId', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseWorksite/Status/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseWorksite/Status/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseWorksite/PostalAddress/Country', :orgid => '00DU0000000ITUe')
partable  =Partable.create(:fieldname => 'BlockBaseWorksite/PostalAddress/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseWorksite/PostalAddress/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/VisitAddress/Address', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/VisitAddress/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/VisitAddress/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/VisitAddress/Country', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/Phone', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockBaseCommunication/Fax', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMBusiness/MainBusiness/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMBusiness/MainBusiness/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMBusiness/Businesses/Business/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMBusiness/Businesses/Business/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/ShareCapital/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/ShareCapital/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/ShareCapital/Value', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/ShareCapital/Start', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/ShareCapital/End', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/Turnover/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/Turnover/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/Turnover/Value', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/Turnover/Start', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMEconomy/Turnover/End', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/Zipcode', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/City', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/Municipality/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/Municipality/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/County/Code', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'BlockCRMGeography/County/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/Country/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGeography/Country/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/OfficialWorksiteNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/WorksiteType/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/WorksiteType/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/CompanyNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/VatNo', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/LegalName', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/LegalForm/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/LegalForm/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/CompanyType/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMOrganization/CompanyType/Text', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'BlockCRMSize/NumberOfEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/NumberOfEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/NumberOfOfficeEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/NumberOfOfficeEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/CompanyNumberOfWorksites', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/CompanyNumberOfEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/CompanyNumberOfEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/CompanyNumberOfOfficeEmployees/Code', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMSize/CompanyNumberOfOfficeEmployees/Text', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGroup/CompanyDbId', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGroup/CompanyNumber', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGroup/CompanyName', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockCRMGroup/Country', :orgid => '00DU0000000ITUe')
partable = Partable.create(:fieldname => 'BlockPlusCommunication/WWW', :orgid => '00DU0000000ITUe')

partable = Partable.create(:fieldname => 'BlockBaseWorksite/Name', :orgid => '456')
partable = Partable.create(:fieldname => 'BlockBaseWorksite.parId', :orgid => '456')


Selectedcontactfield.delete_all
selectedcfield = Selectedcontactfield.create(:parfield => 'BlockBaseContact/FirstName', :sfdcfield => 'FirstName', :orgid =>'00DU0000000ITUe')
selectedcfield = Selectedcontactfield.create(:parfield => 'BlockBaseContact.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'00DU0000000ITUe')

selectedcfield = Selectedcontactfield.create(:parfield => 'BlockBaseContact/FirstName', :sfdcfield => 'FirstName', :orgid =>'456')
selectedcfield = Selectedcontactfield.create(:parfield => 'BlockBaseContact.parId', :sfdcfield => 'PAR121__parId__c', :orgid =>'456')


ContactPartable.delete_all
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/FirstName', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact.parId', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/LastName', :orgid => '00DU0000000ITUe')
cpartable  =ContactPartable.create(:fieldname => 'BlockBaseContact/PersonDbId', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Gender/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Gender/Text', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Language/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Language/Text', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Status/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/Status/Text', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/PersonStatus/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/PersonStatus/Text', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseContact/WorksiteDbId', :orgid => '00DU0000000ITUe')

cpartable = ContactPartable.create(:fieldname => 'BlockBaseCommunication/BlockCRMPosition/MainPosition/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseCommunication/BlockCRMPosition/MainPosition/Text', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseCommunication/BlockCRMPosition/Positions/Position/Code', :orgid => '00DU0000000ITUe')
cpartable = ContactPartable.create(:fieldname => 'BlockBaseCommunication/BlockCRMPosition/Positions/Position/Text', :orgid => '00DU0000000ITUe')

cpartable = ContactPartable.create(:fieldname => 'BlockPlusCommunication/Email', :orgid => '00DU0000000ITUe')

