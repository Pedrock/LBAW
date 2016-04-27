function changePage(page)
{
	$(".product").remove();
	for (var i = 0; i < limit; i++)
	{
		var product = products[(page-1)*limit+i];
		$("#products").append(
			'<div class="product col-lg-3 col-md-4 col-sm-6 text-center"> \
			<div class="thumbnail"> \
			<a href="product.php?id='+product.id+'" class="link-p"> \
				<img src="../images/products/'+product.photo+'" alt=""> \
				</a> \
				<div class="caption"> \
					<h4><a href="product.php?id='+product.id+'">'+product.name+'</a></h4> &nbsp; \
						<div class="pull-left price">'+product.price+'€</div> \
						<a href="#" class="pull-right button-product"> \
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a> \
				</div> \
			</div> \
		</div>');
	}

	var startpage = Math.max(1,page-2);
	var endpage = Math.min(n_pages,page+2);
	var dif = endpage - startpage;
	if (dif < 4)
	{
		if (startpage > 1)
			startpage -= Math.min(startpage-1,4-dif);
		else if (endpage < n_pages)
			endpage += Math.min(n_pages-endpage,4-dif);
	}

	$(".pagination").empty();
	if (page != startpage)
		$(".pagination").append(' \
		<li><a href="#" onclick="changePage(1);return false;">&laquo; First</a></li> \
		<li><a href="#" onclick="changePage('+(page-1)+');return false;">&lsaquo; Previous</a></li>');
	else
		$(".pagination").append(' \
		<li class="hidden-xs disabled"><a>&laquo; First</a></li> \
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>');
	
	for (var p=startpage; p <= endpage; p++)
	{
		if (p == page)
			$(".pagination").append('<li class="active"><a href="#" onclick="changePage('+p+');return false;">'+p+'</a></li>');
		else
			$(".pagination").append('<li><a href="#" onclick="changePage('+p+');return false;">'+p+'</a></li>');
	}
	
	if (page != endpage)
		$(".pagination").append(' \
		<li><a href="#" onclick="changePage('+(page+1)+');return false;">Next &rsaquo;</a></li> \
		<li><a href="#" onclick="changePage('+n_pages+');return false;">Last &raquo;</a></li>');
	else
		$(".pagination").append(' \
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li> \
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>');
	
}