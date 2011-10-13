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
      
  
$( init );
//selected = new Hash();
var selected = new Object();


function stripEscapes(st)
{
	var retVal="";
	for (i=0; i<st.length; i++)
  	{
  		if(st[i]!="\"" && st[i]!="\[" && st[i]!="\]" && st[i]!=" " && st[i]!="}" && st[i]!="{")
  		retVal = retVal + st[i];
  	}
  	return retVal;
}

function checkDuplicates(arr1, arr2) 
{
	for (var i = 0; i<arr1.length; i++) {
	var arrlen = arr2.length;
	for (var j = 0; j<arrlen; j++) {
		if (arr1[i] == arr2[j]) {
			arr2 = arr2.slice(0, j).concat(arr2.slice(j+1, arrlen));
		}
	}
  }
   return arr2;     
}
function replaceDuplicates(arr1, arr2,arr3) 
{	
	var value= '';
	for (var i = 0; i<arr1.length; i++) {
		var arrlen = arr2.length;
		for (var j = 0; j<arrlen; j++) {
			if (arr1[i] == arr2[j]) {
			value = arr3[i] + " -> " + arr2[j];
			arr2[j] = value;
		}
	}
  }
   return arr2;     
}


function init(par, sfdc, selectedfields) {
  // assign the parameters into javascript arrays 
  
  var parstr = stripEscapes(par);
  var sfdcstr = stripEscapes(sfdc);
  var initselected = stripEscapes(selectedfields);
  
  
  // Hide the success message and convert rails variables into JS variables
  $('#successMessage').hide();
  var parf = new Array();
  parf = parstr.split(",") ;
  
  var sfdcf = new Array();
  sfdcf = sfdcstr.split(",") ;
  
  var initsel = new Array();
  initsel = initselected.split(",");
  
 
//  $('#parField').html("PAR Fields");
//  $('#sfdcField').html("Available SFDC Fields" );
  
	
  // Create the par field list
  //parf = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StstusCode__c"];
  //document.write(parf.toString());
  // converting ruby hash as javascript hash and assigning into handledrop varibale
  var hash_selected = new Object();
  var key = '';
  var value = '';
  var keys = new Array();
  var values = new Array();
  //keys will hold SFDC fields and values will hold PAR fields from the selected list
 // alert("starting");
  for (var i =0; i<initsel.length; i++) {
  	key = initsel[i].split(":")[0];
  	value =initsel[i].split(":")[1];
  	hash_selected[key] = value;
  	selected[key] = value;
  	keys.push(key);
  	values.push(value);
  	//.write(keys);
  }
  // handle the selected fields in the available list
   parf = checkDuplicates(values,parf);
   sfdcf = replaceDuplicates(keys,sfdcf, values); 
 
  //Dsiplay the drag and drop columns
  
  for ( var i=0; i<parf.length; i++ ) {
      $('<div>' + parf[i] + '</div>').data( 'number', parf[i] ).attr( 'id', 'parfield'+parf[i] ).appendTo( '#parField' ).draggable( {
     // containment: '#content',
      stack: '#parField div',
      cursor: 'move',
      revert: true,
      drop: handleFieldDrop
    });
  }
   
  // Create the sfdc field list
 // var sfdcf = ["WorksiteBlock/BlockBaseWorksite/Name", "WorksiteBlock/BlockBaseWorksite.parId", "WorksiteBlock/BlockCRMOrganization/CompanyNumber"];
 // alert(sfdcf);
 
  for ( var i=0; i<sfdcf.length; i++ ) {
  	if (sfdcf[i].indexOf('->') == -1) {
  	  $('<div>' + sfdcf[i] + '</div>').data( 'number', sfdcf[i] ).attr( 'id', 'sfdcfield'+sfdcf[i]  ).appendTo( '#sfdcField' ).droppable( {
      	accept: '#parField div',
      	hoverClass: 'hovered',
      	drop: handleFieldDrop
    	} );
   	 }
   else {
   		$('<div>' + sfdcf[i] + '</div>').data( 'number', sfdcf[i] ).attr( 'id', 'sfdcfield'+sfdcf[i]  ).appendTo( '#notDroppable' )
     }
  }
//   for (key in hash_selected) {
//  	$('<div>' + hash_selected[key] + '</div>').data('number', hash_selected[key] ).attr('id','selfield'+ hash_selected[key] ).appendTo('#selField')
//  }
}
  
function handleFieldDrop( event, ui ) {
  var sfdc_pos = $(this).data( 'number' );
  var par_pos = ui.draggable.data( 'number' );
  selected[sfdc_pos] = par_pos;  
//  alert( "Drag stopped!: (" + selected[par_pos]+ '  '+ [par_pos] +  ")\n");
  
  $(this).droppable( 'disable' );
  ui.draggable.position( { of: $(this), my: 'left top', at: 'left top' } );
  ui.draggable.draggable( 'option', 'revert', false );
 
}

function mySuccess()
{
	alert("Your changes have been saved");
	window.top.location="/welcome/index";
	//document.getElementById("message").innerHTML = "Your changes have been saved";
}

function doSaveAs(){
	var theRequestPost= {};
	 theRequestPost['field_mapping'] = selected;
	//theRequestPost = selected;
	try{
		
		//alert(selected);
     	//$.post('http://10.3.0.192:8080/Listener/foo','hello');
      	$.post('/welcome/selectedfieldPersist', theRequestPost,  mySuccess);
 //       alert(theRequestPost);
 //       alert("leaving ajax call");
        return false;
       }
    catch (e)
    {
    	alert("EXCEPTION "+e);
    }
      

 }