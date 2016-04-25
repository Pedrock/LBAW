{assign "title" "HashStore - Search"}
{assign "css" ["category.css"]}
{include file='common/header.tpl'}

<div id="main-title">
	<span class="title">Search: {$query}</span>
</div>
<div class="sort_div pull-left">
	<div class="form-group">
		<select class="form-control" id="sel_sort">
			<option value="" disabled selected>Sort by</option>
			<option>a..z</option>
			<option>z..a</option>
			<option>Price asc.</option>
			<option>Price desc.</option>
		</select>
	</div>
</div>

{if $n_pages > 0}
<div class="text-center">
	<ul class="pagination pagination-sm">
		{if $page != $startpage} 
		<li><a href="search.php?q={$query}&page=1">&laquo; First</a></li>
		<li><a href="search.php?q={$query}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="search.php?q={$query}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="search.php?q={$query}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="search.php?q={$query}&page={$n_pages}">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{else}
<div id="no-pagination"></div>
{/if}

<div class="container-fluid">
	<div class="row">

		{foreach from=$products item=product}
		<div class="col-lg-3 col-md-4 col-sm-6 text-center">
			<div class="thumbnail">
			<a href="product.php?id={$product.id}" class="link-p">
				<img src="../images/products/product-1.jpg" alt="">
				</a>
				<div class="caption">
				
					<h4><a href="product.php?id={$product.id}">{$product.name}</a></h4>
					&nbsp;
						<div class="pull-left price">{$product.price}€</div>
						<a href="#" class="pull-right button-product">
						<span class="glyphicon glyphicon-shopping-cart"></span> <div class="plus"><span class="glyphicon glyphicon-plus"></span></div></a>
				</div>
			</div>
		</div>
		{foreachelse}
		<div class="text-center">No results found.</div>
		{/foreach}
	</div>
</div>

{if $n_pages > 0}
<div class="text-center">
	<ul class="pagination pagination-sm">
		{if $page != $startpage} 
		<li><a href="search.php?q={$query}&page=1">&laquo; First</a></li>
		<li><a href="search.php?q={$query}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="search.php?q={$query}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="search.php?q={$query}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="search.php?q={$query}&page={$n_pages}">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}

{include file='common/footer.tpl'}