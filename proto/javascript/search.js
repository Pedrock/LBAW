function changeOrder()
{
	var order = $("#sel_sort").val();
	document.location.href = '?q='+query+'&order='+order;
}