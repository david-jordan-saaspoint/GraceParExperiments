function cust_pref(name) {
	
    var x = document.getElementById("register_mail")
  	var y = document.getElementById("register_phone")
  	var z = document.getElementById("register_email1")
  	var name2 = document.getElementById("register_none")
  	if ((x.checked == true) || (y.checked == true) || (z.checked == true))
 		{ 	
   			name2.checked = false
        	name2.disabled = true 
        }
     else
     {
     		
   			name2.disabled = false 
     }
   	
 } 
        
        
// jQuery(document).ready(function($) {
//    jQuery("input[type=checkbox]").click(function() {
//        var name = (this.name)
//        var name2 = document.getElementById("register_none")
//        alert(name == "register[mail]")
//        if ((name == "register[mail]") && (this.checked == true))
////        alert("in")
//        {	name2.checked = false
//        	name2.disabled = true }
 //       
 //   })
//})

function cust_pref_none(name) {
	
    var x = document.getElementById("register_mail")
  	var y = document.getElementById("register_phone")
  	var z = document.getElementById("register_email1")
  	var name2 = document.getElementById("register_none")
  	if (name2.checked == true)
 		{ 	
 			x.checked = false
 			y.checked = false
 			z.checked = false
   			x.disabled = true
   			y.disabled = true
   			z.disabled = true 
        }
     else
     {
     		
   			x.disabled = false
   			y.disabled = false
   			z.disabled = false 
     }
   	
 } 