{assign "title" "HashStore"}
{assign "display_carousel" true}
{assign "css" ['category.css']}
{include file='common/header.tpl'}
<ol class="breadcrumb">
	<li><a href="index.php">Home</a></li>
    {foreach from=$breadcrumbs|@array_reverse:true item=cat}
    	{if $cat.id == $category}
    		<li class="active">{$cat.name}</li>
    	{else}
    		<li><a href="category.php?id={$cat.id}">{$cat.name}</a></li>
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
		<li><a href="category.php?id={$category}&page={$page-1}">&laquo;</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="category.php?id={$category}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="category.php?id={$category}&page={$page+1}">&raquo;</a></li>
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
		<li><a href="category.php?id={$category}&page={$page-1}">&laquo;</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="category.php?id={$category}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="category.php?id={$category}&page={$page+1}">&raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}

{include file='common/footer.tpl'}