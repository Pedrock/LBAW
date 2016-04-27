{assign "title" "HashStore"}
{assign "display_carousel" true}
{include file='common/header.tpl'}
{assign "js" ['index.js']}

<div id="f"></div>
<div id="main-title">
	<span class="title">Featured Products</span>
</div>

<div class="container-fluid">
	<div id="products" class="row">
		{foreach from=$products item=product}
		{if $product@iteration <= $limit}
		<div class="product col-lg-3 col-md-4 col-sm-6 text-center">
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
		{else}
			{break}
		{/if}
		{foreachelse}
		<div class="text-center">No featured products yet.</div>
		{/foreach}

	</div>
</div>
{if $n_pages > 0}
<div class="text-center">
	<ul class="pagination pagination-sm">
		{if $page != $startpage} 
		<li><a href="#" onclick="changePage(1);return false;">&laquo; First</a></li>
		<li><a href="#" onclick="changePage({$page-1});return false;">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="#" onclick="changePage({$p});return false;">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="#" onclick="changePage({$page+1});return false;">Next &rsaquo;</a></li>
		<li><a href="#" onclick="changePage({$n_pages});return false;">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}

<script> 
var limit = {$limit};
var n_pages = {$n_pages};
var products = {$products|@json_encode}; 
</script>

{include file='common/footer.tpl'}