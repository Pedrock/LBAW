{assign "title" "HashStore - Search"}
{assign "css" ["category.css"]}
{assign "js" ['list.js','cart_common.js']}

<!-- 
	Setup the link variables
-->

{if $query}{assign "lnk_query" value="&search={$query}"}{/if}
{if $category}{assign "lnk_categ" value="&cat={$category}"}{/if}
{if $order}{assign "lnk_order" value="&order={$order}"}{/if}
{assign "pag_link" value="{$lnk_query}{$lnk_order}{$lnk_categ}"}

{include file='common/header.tpl'}

{if $query}
	<div id="main-title">
		<span class="title">Search: {$query}</span>
	</div>
{/if}

{if not $query or $breadcrumbs}
	<ol class="breadcrumb">
		<li><a href="list.php?{$lnk_query}{$lnk_order}">All Categories</a></li> <!-- TODO -->
		{if $breadcrumbs}
			{foreach from=$breadcrumbs|@array_reverse:true item=cat}
				{if $cat.id == $category}
					<li class="active">{$cat.name}</li>
				{else}
					<li><a href="?cat={$cat.id}{$lnk_query}{$lnk_order}">{$cat.name}</a></li>
				{/if}
			{/foreach}
		{/if}
	</ol>
{/if}

<div class="sort_div pull-left">
	<div class="form-group">
		<select class="form-control" id="sel_sort" onChange="changeOrder()">
			<option value="" disabled>Sort by</option>
			<option value="" {if $order == ""} selected{/if}>Relevance</option>
			<option value="na"{if $order == "na"} selected{/if}>a..z</option>
			<option value="nd"{if $order == "nd"} selected{/if}>z..a</option>
			<option value="pa"{if $order == "pa"} selected{/if}>Price asc.</option>
			<option value="pd"{if $order == "pd"} selected{/if}>Price desc.</option>
		</select>
	</div>
</div>

{if $n_pages > 0}
	<div class="text-center">
		<ul class="pagination pagination-sm">
			{if $page != $startpage} 
			<li><a href="?page=1{$pag_link}">&laquo; First</a></li>
			<li><a href="?page={$page-1}{$pag_link}">&lsaquo; Previous</a></li>
			{else}
			<li class="hidden-xs disabled"><a>&laquo; First</a></li>
			<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
			{/if}
			{for $p=$startpage to $endpage}
			<li{if $p == $page} class="active"{/if}><a href="?page={$p}{$pag_link}">{$p}</a></li>
			{/for}
			{if $page != $endpage}
			<li><a href="?page={$page+1}{$pag_link}">Next &rsaquo;</a></li>
			<li><a href="?page={$n_pages}{$pag_link}">Last &raquo;</a></li>
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
			<div class="product col-lg-3 col-sm-6 text-center">
				<div class="thumbnail" data-id="{$product.id}">
					<a href="product.php?id={$product.id}" class="link-p">
						<img{if $product.photo} src="../images/products/thumb_{$product.photo}"{else} src="../images/assets/default_product.png"{/if} alt="">
					</a>
					<div class="caption">
						<h4><a class="product-name" href="product.php?id={$product.id}">{$product.name}</a></h4> &nbsp;
						<div class="pull-left price">{$product.price} €</div>
						<a href="#" onclick="addToCart({$product.id});return false;" class="pull-right button-product">
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
			<li><a href="?page=1{$pag_link}">&laquo; First</a></li>
			<li><a href="?page={$page-1}{$pag_link}">&lsaquo; Previous</a></li>
			{else}
			<li class="hidden-xs disabled"><a>&laquo; First</a></li>
			<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
			{/if}
			{for $p=$startpage to $endpage}
			<li{if $p == $page} class="active"{/if}><a href="?page={$p}{$pag_link}">{$p}</a></li>
			{/for}
			{if $page != $endpage}
			<li><a href="?page={$page+1}{$pag_link}">Next &rsaquo;</a></li>
			<li><a href="?page={$n_pages}{$pag_link}">Last &raquo;</a></li>
			{else}
			<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
			<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
			{/if}
		</ul>
	</div>
{/if}

<script>
	var query = '{$query}';
	var category = '{$category}';
</script>

{include file='common/footer.tpl'}