
function validate(){
	var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{1,5})$/;
	var fname = document.getElementById("fname").value; 
	var lname = document.getElementById("lname").value; 
	
	var landline = document.getElementById("landline").value; 
	var mobile = document.getElementById("mobile").value; 
	var crn = document.getElementById("crn").value; 
	var spid = document.getElementById("spid").value; 
 if (fname.length === 0) {
  alert("You must enter a first name.");
  return false;
 }

 if (lname.length === 0) {
  alert("You must enter a last name.");
  return false;
 }
 var email = document.getElementById("email").value; 
 
 if(reg.test(email) == false) {
     alert('Invalid Email Address');
     changeColor(email)
      return false;
   }

 if (crn.length === 0) {
  alert("You must enter a Customer Reference Number.");
  return false;
 }
 if (spid.length === 0) {
  alert("You must enter a Supply Point ID.");
  return false;
 }
 
  if (landline.length > 0)
  {
  	var form_phone = isNumeric(landline)
  return false;
  }
  if (mobile.length > 0)
  {
  	var form_phone = isNumeric(mobile)
  	 return false;
  }
  if ((landline.length === 0) && (mobile.length === 0)) {
  alert("You must enter a valid landline or mobile number");
  return false;
 }
  
 
 return true;
}


function isNumeric(numvalue){
	var numericExpression = /^[0-9]+$/;
	if(numvalue.match(numericExpression)){
		return true;
	}else{
		alert("You must enter a phone number not text.");
		return false;
	}
}
function changeColor(field) {
field.style.backgroundColor="red";

}
   

