/*
 * Sortable Lists
 */
var SortableLists = {
	lists: ["todoList", "doneList"],

	doneList: [1, 2, 3],
		
	todoList: [4, 5, 6, 7, 8, 9, 10],
	
	items: {
		1:  "1. Welcome and Software Installation Lesson",
		2:  "2. JavaScript Basics Lesson",
		3:  "3. More Advanced JavaScript Lesson",
		4:  "4. Using Professional JavaScript Libraries",
		5:  "5. JavaScript Refresher Lesson",
		6:  "6. Ruby Basics Lesson",
		7:  "7. Ruby on Rails Basics Lesson",
		8:  "8. Ajax Basics Lesson",
		9:  "9. Ruby Refresher Lesson",
		10: "10. Party Time, Questions and Answers"
	},

	updated: function (list) {
		var id = list.getAttribute('id');
		var array = SortableLists[id];
		array.length = 0;
		Sortable.sequence(list).each(function (value) {
			array.push(parseInt(value));
		});
		
	},
	
	createSortables: function (event) {
		var lists = SortableLists.lists;

		// create the lists
		lists.each(function (name) {
			var list = SortableLists[name];
			var container = $(name);
			var attrs = { id: 'todo', 'class': 'sortable' };
			list.each(function (id) {
				var text = SortableLists.items[id];
				attrs.id = 'todo_' + id;
				container.insert({ bottom: Builder.node('li', attrs, text) });
			});
		});

		// make them sortable
		lists.each(function (name) {
			Sortable.create(name, {
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