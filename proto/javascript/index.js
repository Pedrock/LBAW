function changePage(page)
{
	$(".product").remove();
	for (var i = 0; i < limit; i++)
	{
		var product = products[(page-1)*limit+i];
		if (product.photo)
			var img = '<img src="../images/products/thumb_'+product.photo+'" alt="">';
		else 
			var img = '<img src="../images/assets/default_product.png" alt="">';
		$("#products").append(
			'<div class="product col-lg-3 col-sm-6 text-center"> \
			<div class="thumbnail" data-id="'+product.id+'"> \
			<a href="product.php?id='+product.id+'" class="link-p">'
				 + img +
				'</a> \
				<div class="caption"> \
					<h4><a class="product-name" href="product.php?id='+product.id+'">'+product.name+'</a></h4> &nbsp; \
						<div class="pull-left price">'+product.price+' €</div> \
						<a href="#" onclick="addToCart('+product.id+');return false;" class="pull-right button-product"> \
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
		<li><a href="javascript:void(0)" onclick="changePage(1);">&laquo; First</a></li> \
		<li><a href="javascript:void(0)" onclick="changePage('+(page-1)+');">&lsaquo; Previous</a></li>');
	else
		$(".pagination").append(' \
		<li class="hidden-xs disabled"><a>&laquo; First</a></li> \
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>');
	
	for (var p=startpage; p <= endpage; p++)
	{
		if (p == page)
			$(".pagination").append('<li class="active"><a href="javascript:void(0)" onclick="changePage('+p+');">'+p+'</a></li>');
		else
			$(".pagination").append('<li><a href="javascript:void(0)" onclick="changePage('+p+');">'+p+'</a></li>');
	}
	
	if (page != endpage)
		$(".pagination").append(' \
		<li><a href="javascript:void(0)" onclick="changePage('+(page+1)+');">Next &rsaquo;</a></li> \
		<li><a href="javascript:void(0)" onclick="changePage('+n_pages+');">Last &raquo;</a></li>');
	else
		$(".pagination").append(' \
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li> \
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>');
	
}