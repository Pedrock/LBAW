function changeOrder() {
	var order = $("#sel_sort").val();
	var final_href = '?order=' + order;
	if(category)
		final_href += '&cat=' + category;
	if(query)
		final_href += '&search=' + query;

	document.location.href = final_href;
}