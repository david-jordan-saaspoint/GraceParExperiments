

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
	var retArr = new Array();
	for (i=0; i<st.length; i++)
  	{
  		if(st[i]!="\"" && st[i]!="\[" && st[i]!="\]" && st[i]!=" " && st[i]!="}" && st[i]!="{")
  		retVal = retVal + st[i];
  		
  	}
  	retArr = retVal.split(","); 
  	return retArr;
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
			value = arr3[i] + " : " + arr2[j];
			arr2[j] = value;
		}
	}
  }
   return arr2;     
}


function init(sfdc, par, selectedfields) {
 
  // Hide the success message and convert rails variables into JS variables
 // $('#successMessage').hide();
 
  var parf = stripEscapes(par);
  var sfdcf = stripEscapes(sfdc);
  
  if(selectedfields != null) {
   	var initsel = stripEscapes(selectedfields);
  //document.write(parf.toString());
  // converting ruby hash as javascript hash and assigning into handledrop varibale
  	var init_sel = new Array()
  	var key =value = '';
  	var keys = new Array();
  	var values = new Array();
  	var item = "";
  //keys will hold PAR fields and values will hold SFDC fields from the selected list
 // alert("starting");
  	for (var i =0; i<initsel.length; i++) {
  		key = initsel[i].split(":")[0];
  		value =initsel[i].split(":")[1];
  		item = key + " : " + value
  		init_sel.push(item);
  		
  		selected[key] = value;
  		keys.push(key);
  		values.push(value);
   	}
    
  }
  // handle the selected fields in the available list. copy sfdcf into sfdcf_orig for deselect option
 //  parf = checkDuplicates(keys,parf);
  // sfdcf = replaceDuplicates(values,sfkeys, keys); 
  // sfdcf = checkDuplicates(values, sfkeys);
   //sfdcf_orig = sfdcf
   
  //Dsiplay the drag and drop columns and selectedfields columns
 var i = j= k= 0;
  for (  i=0; i<parf.length; i++ ) {
     addElementPar(parf[i], i);
  }
   
  // Create the sfdc field list
 // var sfdcf = ["WorksiteBlock/BlockBaseWorksite/Name", "WorksiteBlock/BlockBaseWorksite.parId", "WorksiteBlock/BlockCRMOrganization/CompanyNumber"];
 // alert(sfdcf);
 
  for ( k=0; k<sfdcf.length; k++ ) {
  	  addElementDroppable(sfdcf[k], k);
  }
   	
  for (j=0; j<init_sel.length; j++) {
   	   populate_selected(init_sel[j], j);
  }
 //   for (key in hash_selected) {
//  	$('<div>' + hash_selected[key] + '</div>').data('number', hash_selected[key] ).attr('id','selfield'+ hash_selected[key] ).appendTo('#selField')
//  }
}

function populate_selected( ele, j ) {
	if (ele != " : undefined")
	{
 	$('<div></div>').data( 'number', ele ).attr( 'id', 'notDroppable'+j  ).appendTo( '#notDroppable' );
   	    var sfdcVal =  '<table><tr><td align=left colspan=2><div id=notDroppableText'+j+' class=image>'+ele + '</div></td>'
   	    sfdcVal = sfdcVal + '<td align=right ><img id=image'+j+' src="/images/close.gif" onclick=deselect('+j+')></td></tr>';
   	    sfdcVal = sfdcVal + '</table>';
   	    
   		window.document.getElementById('notDroppable'+j).innerHTML = sfdcVal;
   	  // 		$('<div id="button"> "try me" </div>').data( 'number', 'select' ).attr( 'id', 'selField' + j ).appendTo('#selField')  
    }
   		
   }
  
function handleFieldDrop( event, ui ) {
  
  var parFieldElementId = ui.draggable[0].id;
 
  var sfdcElementId = this.id;
 //add close button to the dropped field
  var sfdc_pos = $(this).data( 'number' );
  var par_pos = ui.draggable.data( 'number' );
  selected[par_pos] = sfdc_pos;  
  j++; k++;
  var ele = par_pos + " : " + sfdc_pos; 
  populate_selected(ele, j); 
  
   		
  window.document.getElementById(parFieldElementId).innerHTML = par_pos + " : " + sfdc_pos;
  window.document.getElementById(parFieldElementId).style.visibility="hidden";
  window.document.getElementById(sfdcElementId).style.visibility="hidden";
  
  //alert( "Drag stopped!: (" + selected[par_pos]+ '  '+ [par_pos] +  ")\n");
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
      	$.post('/welcome/selectedfieldPersist', theRequestPost,  mySuccess);
        return false;
       }
    catch (e)
    {
    	alert("EXCEPTION "+e);
    }
  
 }
 
 function doSaveContactAs(){
	var theRequestPost= {};
	 theRequestPost['field_mapping'] = selected;
	//theRequestPost = selected;
	try{
      	$.post('/welcome/selectedcontactfieldPersist', theRequestPost,  mySuccess);
        return false;
       }
    catch (e)
    {
    	alert("EXCEPTION "+e);
    }
  
 }
 
function trim(str)
 {
 	return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
 }
 
function deselect(arg1){
	var data = $(this).data( 'number' );
	removeElement(arg1);
}
function removeElement(arg1) {	
 // remove nondroppable element
  var label = sfdcField = parField = '';
  var d = document.getElementById('notDroppable');
  var olddiv = document.getElementById('notDroppable'+arg1);
  label = document.getElementById('notDroppableText'+ arg1).innerHTML
  parField = trim(label.split(":")[0]);
  sfdcField = label.split(":")[1];
 //window.document.getElementById('image'+arg1).attributes['disabled']=true;
  d.removeChild(olddiv);

  //remove from save button array
 newselected ={};
  
  for (var key in selected){
  //  	var a = delete selected(parField);
 //	alert(parField)
  	if (key == parField) {
  	}
   	else
  	{
  		newselected[key] = selected[key];
 	}
  }
  selected = newselected;
 // for (var key in selected)
 // 	 alert(key + ":" +selected[key]);
  //add div in sfdcfield and parfield
  addElementDroppable(sfdcField, k++);
  addElementPar(parField, i++);

}

function addElementDroppable(eleName, k ) {	
	var add_to = "";
		 add_to = '#sfdcField'
		$('<div>' + eleName + '</div>').data( 'number', eleName ).attr( 'id', 'droppable'+ k  ).appendTo( add_to ).droppable( {
      		accept: '#parField div',
      		hoverClass: 'hovered',
      		drop: handleFieldDrop
    		} );
    	
}

function addElementPar(eleName, i) {  
	 $('<div>' + eleName + '</div>').data( 'number', eleName ).attr( 'id', 'parfield'+ i ).appendTo( '#parField' ).draggable( {
     // containment: '#content',
      stack: '#parField div',
      cursor: 'move',
      revert: true,
      drop: handleFieldDrop
    });
    var id ="parfield"+ i 
    elem = window.document.getElementById(id)
   
    if (eleName.length > 60)
    	{     
	 	elem.style.width = 330 + 'px';}
    else if (eleName.length > 55)
    	{     
	 	elem.style.width = 300 + 'px';}
    else if (eleName.length > 45)
    	{     
	 	elem.style.width = 280 + 'px';}
	 else if (eleName.length > 40)
	 	elem.style.width = 230 + 'px';
	 else if (eleName.length > 30)
	 	elem.style.width = 200 + 'px';	
	 	else if (eleName.length < 25)
	 	elem.style.width = 120 + 'px';	
}
