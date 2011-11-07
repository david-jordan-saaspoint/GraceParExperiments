function showMoreDetail(Name, Legalname, Department,Address,City,Zipcode,PostalAddress,PostalCity,PostalZipcode, Phone, TypePAR, Status, NOfContacts, parId, CompanyNumber)
{
	
	
	
var msg = '';

if(Name) msg += 'Company_Name: '+ Name;
if(Legalname) msg += '\nLegal_Name: '+ Legalname;
if(Department) msg += '\nDepartment: '+ Department;
if(Address) msg += '\nAddress: '+ Address;
if(City) msg += '\nCity: '+ City;
if(Zipcode) msg += '\nZipcode: '+Zipcode;
if(PostalAddress) msg += '\nPostal_adddress: '+PostalAddress;
if(PostalCity) msg += '\nPostal_city: '+PostalCity;
if(PostalZipcode) msg += '\nPostal_Code: '+PostalZipcode;
if(Phone) msg += '\nPhone: '+ Phone;
if(TypePAR) msg += '\nType_Code: '+TypePAR;
if(Status) msg += '\nStatus: '+Status;
msg += '\nNumber_of_contacts: '+NOfContacts;
if(parId) msg += '\nPAR_ID: '+parId;
if(CompanyNumber) msg += '\nCompany Number: '+CompanyNumber;
alert(msg);
}