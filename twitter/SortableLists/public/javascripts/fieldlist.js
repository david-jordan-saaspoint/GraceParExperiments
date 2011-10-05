var correctCards = 10;

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
function init() {
 
  // Hide the success message
  $('#successMessage').hide();
 
  
  $('#parField').html( 'Available PAR Fields' );
 
  
  $('#sfdcField').html( 'SFDC Fields' );
 
  // Create the par field list
 
  var parf = ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StstusCode__c"];
  for ( var i=0; i<parf.length; i++ ) {
    $('<div>' + parf[i] + '</div>').data( 'number', parf[i] ).attr( 'id', 'parfield'+parf[i] ).appendTo( '#parField' ).draggable( {
      containment: '#content',
      stack: '#parField div',
      cursor: 'move',
      revert: true
    } );
  }
 
  // Create the sfdc field list
  
  var sfdcf = ["WorksiteBlock/BlockBaseWorksite/Name", "WorksiteBlock/BlockBaseWorksite.parId", "WorksiteBlock/BlockCRMOrganization/CompanyNumber"];
  for ( var i=1; i<=sfdcf.length; i++ ) {
    $('<div>' + sfdcf[i-1] + '</div>').data( 'number', i ).appendTo( '#sfdcField' ).droppable( {
      accept: '#parField div',
      hoverClass: 'hovered',
      drop: handleFieldDrop
    } );
  }
 
}
  
function handleFieldDrop( event, ui ) {
  var sfdc_pos = $(this).data( 'number' );
  
  var par_pos = ui.draggable.data( 'number' );
 
  // If the card was dropped to the correct slot,
  // change the card colour, position it directly
  // on top of the slot, and prevent it being dragged
  // again
  var offsetXPos = parseInt( ui.offset.left );
  var offsetYPos = parseInt( ui.offset.top );
  alert( "Drag stopped!\n\nOffset: (" + sfdc_pos + ", " + par_pos + ")\n");
 
//  if ( slotNumber == cardNumber ) {
//    ui.draggable.addClass( 'correct' );
//    ui.draggable.draggable( 'disable' );
    $(this).droppable( 'disable' );
    ui.draggable.position( { of: $(this), my: 'left top', at: 'left top' } );
    ui.draggable.draggable( 'option', 'revert', false );
//    correctCards++;
//  } 
   
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
