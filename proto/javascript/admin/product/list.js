function changeOrder()
{
	var order = $("#sel_sort").val();
	document.location.href = '?category='+category+'&order='+order;
}