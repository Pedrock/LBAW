{assign "title" "HashStore"}
{assign "display_carousel" true}
{assign "js" ['index.js','cart_common.js']}
{include file='common/header.tpl'}

<div id="f"></div>
<div id="main-title">
	<span class="title">Featured Products</span>
</div>

<div class="container-fluid">
	<div id="products" class="row">
		{foreach from=$products item=product}
		{if $product@iteration <= $limit}
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
		<li><a href="javascript:void(0)" onclick="changePage(1);">&laquo; First</a></li>
		<li><a href="javascript:void(0)" onclick="changePage({$page-1});">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="javascript:void(0)" onclick="changePage({$p});">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="javascript:void(0)" onclick="changePage({$page+1});">Next &rsaquo;</a></li>
		<li><a href="javascript:void(0)" onclick="changePage({$n_pages});">Last &raquo;</a></li>
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
var base_url = '{$BASE_URL}';
</script>

{include file='common/footer.tpl'}