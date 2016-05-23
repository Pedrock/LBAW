{assign "title" "HashStore - Search"}
{assign "css" ["category.css"]}
{assign "js" ['search.js','cart_common.js']}
{include file='common/header.tpl'}

<div id="main-title">
	<span class="title">Search: {$query}</span>
</div>

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
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page=1">&laquo; First</a></li>
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="?q={$query}{if $order}&order={$order}{/if}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$n_pages}">Last &raquo;</a></li>
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
						<img src="../images/products/{$product.photo}" alt="">
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
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page=1">&laquo; First</a></li>
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="?q={$query}{if $order}&order={$order}{/if}&page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="?q={$query}{if $order}&order={$order}{/if}&page={$n_pages}">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}

<script>
var query = '{$query}';
</script>

{include file='common/footer.tpl'}