function changeOrder()
{
	var order = $("#sel_sort").val();
	document.location.href = '?id='+category+'&order='+order;
}