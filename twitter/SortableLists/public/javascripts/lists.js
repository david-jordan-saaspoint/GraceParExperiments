/*
 * Sortable Lists
 */



var map_var = {
		1:  "Name",
		2:  "PAR121__parId__c",
		3:  "AccountNumber",
		4:  "PAR121__Status__c",
		5:  "PAR121__StatusCode__c",
		6:  "PAR121__Active_c",
		7:  "BillingCity",
		8:  "BillingCountry",
		9:  "Id",
		10: "PAR121__CompanyNumber__c"};
		
var getVar = {};		
		
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
      

		
var SortableLists = {
	lists: ["availableList", "selectedList", ],

	selectedList: [],
	
	availableList: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
	

//	doneList: ["Name", "PAR121__parId__c", "AccountNumber", "PAR121__Status__c", "PAR121__StstusCode__c"],
	
//	todoList: ["WorksiteBlock/BlockBaseWorksite/Name", "WorksiteBlock/BlockBaseWorksite.parId", "WorksiteBlock/BlockCRMOrganization/CompanyNumber"],
	
	items:  map_var,
	
	updated: function (list, ui) {
		var id = list.getAttribute('id');
		var array = SortableLists[id];
		array.length = 0;
		Sortable.sequence(list).each(function (value) {
			array.push(parseInt(value));
		});
		
		// Debugging code
		$('feedback').innerHTML = "<pre>" + "After Drag and Drop" + "\n " + 
			"  Available Fields: " + SortableLists.availableList.inspect() + "\n " +
			"  Selected Fields: " + SortableLists.selectedList.inspect() +"\n " +
			"  Selected : " + SortableLists[id] +
			"</pre>";
	},
	
	createSortables: function (event, ui) {
		var lists = SortableLists.lists;

		// create the lists
		lists.each(function (name) {
			var list = SortableLists[name];
			var container = $(name);
			var attrs = { id: 'availablePAR', 'class': 'sortable' };
			list.each(function (id) {
				var text = SortableLists.items[id];
				attrs.id = 'availablePAR_' + id;
				
				container.insert({ bottom: Builder.node('li', attrs, text) });
			});
			
		});

		// make them sortable
		lists.each(function (id) {
			Sortable.create(id, {
				dropOnEmpty: true,
				containment: lists,
				constraint: false,
				only: 'sortable',
				onUpdate: SortableLists.updated
			});
		});
	}
};

document.observe("dom:loaded", SortableLists.createSortables);