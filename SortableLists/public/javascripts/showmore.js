function showMoreDetail(Flag, Name, Legalname, Department,Address,City,Zipcode,PostalAddress,PostalCity,PostalZipcode, 
	Phone, TypePAR, Status, NOfContacts, parId, CompanyNumber, Id, DbId, TypeCode, StatusCode)
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


if(parId) msg += '\nPAR_ID: '+parId;
if(CompanyNumber) msg += '\nCompany Number: '+CompanyNumber;
if (Flag == "Dup")
{
	msg += '\nSubscribed: '+NOfContacts;
	if(Id) msg += '\nId: '+Id;
	if(DbId) msg += '\nDBId: '+DbId;
	if(TypePAR) msg += '\nType_Code: '+TypePAR + '/' + TypeCode;
	if(Status) msg += '\nStatus: '+Status + '/' + StatusCode ;
}

else
{
msg += '\nNumber_of_contacts: '+NOfContacts;
if(TypePAR) msg += '\nType_Code: '+TypePAR;
if(Status) msg += '\nStatus: '+Status ;

}


alert(msg);
}
