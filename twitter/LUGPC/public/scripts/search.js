/*
 * Word Search
 */

document.observe('dom:loaded', function() {
  new Ajax.Autocompleter('search', 'results', '/word', {
    method: 'get',
    minChars: 2,
    updateElement: function(item) { /* no update */ }
  });
});