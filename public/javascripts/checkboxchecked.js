function cust_pref(name) {
	{
  
  alert('here')
  alert(window.document.getElementById(name).checked)
   alert(window.document.getElementById(name).checked)
  if (document.getElementById(name).checked == true)
 { alert("in")
  'none'.disabled = true }
        
    
 
}
//    var element = Event.element(e)
 //   alert(e)
 // var index = element.selectedIndex
 // var option = element.options[index]

 // if(option.value == "Show fields")
 //    $('none').attr('disabled', true).css({
 //               color: '#f5f5f5'
  //          });
 // else
  //  $('hidden-fields').hide()
//	{
 //           $('none').attr('disabled', false).css({
  //              color:  '#666666'
   //         });
    //    }
           
} 
        
        
 jQuery(document).ready(function($) {
    jQuery("input[type=checkbox]").click(function() {
        alert('It works!')
        alert(this.checked)
        var name = (this.name)
        alert(name)
       // alert(name == register[mail])
        if ( (this.checked == true))
        alert("in")
        {'none'.disabled = true }
        
    })
})

