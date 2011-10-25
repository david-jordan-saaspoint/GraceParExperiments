// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
    function DoAction(msg) {
	getVar = msg;
	alert("from parameter:" + getVar);
	return false;
	}		
		
$(function () {  
        $('#alert').click(function () {  
          alert("welcome"); 
        // alert(this.getAttribute('message')); 
          return false;  
        })  
      });  
      
 

