function changeOrder() {
	var order = $("#sel_sort").val();
	document.location.href = '?category='+category+'&order='+order+'&search='+search + (promotion ? "&promotion" : "");
}

$("#form-edit-product").on('submit', function(event) {
	event.preventDefault();
	event.stopPropagation();
	var order = $("#sel_sort").val();
	document.location.href = '?category='+category+'&order='+order+'&search='+$("#search_query").val() + (promotion ? "&promotion" : "");
});