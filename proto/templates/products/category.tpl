{assign "title" "HashStore"}
{assign "css" ['category.css']}
{include file='common/header.tpl'}
<ol class="breadcrumb">
	<li><a href="index.php">Home</a></li>
    {foreach from=$breadcrumbs|@array_reverse:true item=cat}
    	{if $cat.id == $category}
    		<li class="active">{$cat.name}</li>
    	{else}
    		<li><a href="?id={$cat.id}">{$cat.name}</a></li>
    	{/if}
    {/foreach}
</ol>

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
		<li><a href="?id={$category}&page=1">&laquo; First</a></li>
		<li><a href="?id={$category}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="?id={$category}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="?id={$category}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="?id={$category}&page={$n_pages}">Last &raquo;</a></li>
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
				<img src="../images/products/{$product.photo}" alt="">
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
		<div class="text-center">No products in this category.</div>
		{/foreach}
	</div>
</div>

{if $n_pages > 0}
<div class="text-center">
	<ul class="pagination pagination-sm">
		{if $page != $startpage} 
		<li><a href="?id={$category}&page=1">&laquo; First</a></li>
		<li><a href="?id={$category}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="?id={$category}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="?id={$category}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="?id={$category}&page={$n_pages}">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}

{include file='common/footer.tpl'}