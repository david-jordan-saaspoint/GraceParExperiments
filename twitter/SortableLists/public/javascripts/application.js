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
  		if(st[i]!="\"" && st[i]!="\[" && st[i]!="\]" && st[i]!=" " && st[i]!="}")
  		retVal = retVal + st[i];
  	}
  	return retVal;
}

function init(par, sfdc, selectedfields) {
  // assign the parameters into javascript arrays 
  
  var parstr = stripEscapes(par);
  var sfdcstr = stripEscapes(sfdc);
  var initselected = stripEscapes(selectedfields);
  
  
  // Hide the success message
  $('#successMessage').hide();
  var parf = new Array();
  parf = parstr.split(",") ;
  
  var sfdcf = new Array();
  sfdcf = sfdcstr.split(",") ;
  
  var initsel = new Array();
  initsel = initselected.split(",");
  
 for(var index in initselected) {
  //document.write( index + " : " + initselected[index] + "<br />");
}
  $('#parField').html("PAR Fields");
  $('#sfdcField').html("SFDC Fields" );
  $('#selField').html("Selected Fields");
	
  // Create the par field list
  //parf = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StstusCode__c"];
  //document.write(parf.toString());
  var hash_selected = new Object();
  var key = '';
  var value = '';
  for (var i =0; i<initsel.length; i++) {
  	key = initsel[i].split(":")[0];
  	value =initsel[i].split(":")[1];
  	hash_selected[key] = value;
  }
  
 //alert("starting");
  
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
    $('<div>' + sfdcf[i] + '</div>').data( 'number', sfdcf[i] ).attr( 'id', 'sfdcfield'+sfdcf[i]  ).appendTo( '#sfdcField' ).droppable( {
      accept: '#parField div',
      hoverClass: 'hovered',
      drop: handleFieldDrop
    } );
  }
   for (key in hash_selected) {
  	
  	$('<div>' + hash_selected[key] + '</div>').data('number', hash_selected[key] ).attr('id','selfield'+ hash_selected[key] ).appendTo('#selField')
  }
   
  
  
}
  
function handleFieldDrop( event, ui ) {
  var sfdc_pos = $(this).data( 'number' );
  var par_pos = ui.draggable.data( 'number' );
  selected[par_pos] = sfdc_pos;  
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