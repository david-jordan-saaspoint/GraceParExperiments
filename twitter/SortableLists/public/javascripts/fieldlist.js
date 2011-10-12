

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
selected = new Hash();
function init(par, sfdc) {
  // assign the parameters into javascript arrays 
  var parstr = par;
  parstr = parstr.slice(0,-1);
  parstr = parstr.slice(1);
   
  var sfdcstr = sfdc;
  sfdcstr = sfdcstr.slice(0,-1);
  sfdcstr = sfdcstr.slice(1);
  // Hide the success message
  $('#successMessage').hide();
  var parf = new Array();
  parf = parstr.split(",") ;
  
  var sfdcf = new Array();
  sfdcf = sfdcstr.split(",") ;
  $('#parField').html("PAR Fields");
  $('#sfdcField').html( 'SFDC Fields' );
 


	
  // Create the par field list
  //parf = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StstusCode__c"];
 //document.write(parf.toString());

  for ( var i=0; i<parf.length; i++ ) {
    $('<div>' + parf[i] + '</div>').data( 'number', parf[i] ).attr( 'id', 'parfield'+parf[i] ).appendTo( '#parField' ).draggable( {
     // containment: '#content',
      stack: '#parField div',
      cursor: 'move',
      revert: true,
      drop: handleFieldDrop
    } );
  }
   
  // Create the sfdc field list
  
 // var sfdcf = ["WorksiteBlock/BlockBaseWorksite/Name", "WorksiteBlock/BlockBaseWorksite.parId", "WorksiteBlock/BlockCRMOrganization/CompanyNumber"];
  for ( var i=1; i<=sfdcf.length; i++ ) {
    $('<div>' + sfdcf[i-1] + '</div>').data( 'number', parf[i] ).attr( 'id', 'parfield'+parf[i]  ).appendTo( '#sfdcField' ).droppable( {
      accept: '#parField div',
      hoverClass: 'hovered',
      drop: handleFieldDrop
    } );
  }
  
}
  
function handleFieldDrop( event, ui ) {
  
  var sfdc_pos = $(this).data( 'number' );
  var par_pos = ui.draggable.data( 'number' );
  a = selected.set(sfdc_pos, par_pos);
  
  //alert( "Drag stopped!\n\nOffset: (" + a + ")\n");
  
  $(this).droppable( 'disable' );
  ui.draggable.position( { of: $(this), my: 'left top', at: 'left top' } );
  ui.draggable.draggable( 'option', 'revert', false );

  // If all the cards have been placed correctly then display a message
  // and reset the cards for another go
 
//  if ( correctCards == 10 ) {
//    $('#successMessage').show();
//    $('#successMessage').animate( {
//      left: '380px',
//      top: '200px',
//      width: '400px',
//      height: '100px',
//      opacity: 1
//    } );
//  }

}

function doSaveAs(){
	alert("selectedfields:" + selected.inspect());
	var c = {};
        c['authenticity_token'] = encodeURIComponent(window._token);
        $.ajax({
        type: "POST",
        url: "selectedfield",
        data: selected.inspect(),
        });

//var url = '/welcome/selectedfield?message='+encodeURIComponent(selected.inspect()); 
//new Ajax.Request(url, 
//{ asynchronous:true, evalScripts:true, method:'get', 
//onComplete: function(t) { 
//	('#form').hide();
// } 
//}); 
   }