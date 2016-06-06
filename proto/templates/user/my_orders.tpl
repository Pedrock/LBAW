{assign "title" {"HashStore - My Orders"}}
{assign var="css" value=['my_orders.css']}
{assign var="js" value=['user/my_orders.js']}
{include file='common/header.tpl'}

<div id="main-title">
	<span class="title">Order History</span>
</div>

{if $n_pages > 0}
<div class="text-center">
	<ul class="pagination pagination-sm">
		{if $page != $startpage} 
		<li><a href="?page=1">&laquo; First</a></li>
		<li><a href="?page={$page-1}">&lsaquo; Previous</a></li>
		{else}
		<li class="hidden-xs disabled"><a>&laquo; First</a></li>
		<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
		{/if}
		{for $p=$startpage to $endpage}
		<li{if $p == $page} class="active"{/if}><a href="?page={$p}">{$p}</a></li>
		{/for}
		{if $page != $endpage}
		<li><a href="?page={$page+1}">Next &rsaquo;</a></li>
		<li><a href="?page={$n_pages}">Last &raquo;</a></li>
		{else}
		<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
		<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
		{/if}
	</ul>
</div>
{/if}
{if $orders}
<div class="panel panel-primary" id="accordion">
	<div class="panel-heading">
		<div class="top_row row">
			<div class="col-xs-4">Number</div>
			<div class="col-xs-4">Date</div>
			<div class="col-xs-2 hidden-xs">Total</div>
		</div>
	</div>
	<div id="accordion-container" class="panel-orders-list panel-body">
		<div class="order panel panel-primary">
			{foreach from=$orders item=order}
			<a class="order-accordion loadable" data-toggle="collapse" data-parent="#accordion-container" href="#{$order.id}" data-id="{$order.id}">
				<div class="panel-heading">
					<div id="order_id" class="col-xs-4">#{$order.id}</div>
					<div class="order_date col-xs-4">{$order.orderdate}</div>
					<div class="col-xs-2 hidden-xs">{$order.price}€</div>
					&nbsp;
				</div>
			</a>
			<div id="{$order.id}" class="order-info panel-collapse collapse">
				<div class="panel-body">
					<div class="loading text-center">
						<i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
						<span class="sr-only">Loading...</span>
					</div>
				</div>
			</div>
			{/foreach}
		</div>
	</div>
</div>
{else}
	<div class="text-center">You have no orders yet.</div>
{/if}
<div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="cartModal" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">Added to Cart</h4> 
				</div>
				<div class="modal-footer"> 
					<a type="button" class="btn btn-default" href="../cart.php">Go to Cart</a> 
					<button type="button" class="btn btn-primary" data-dismiss="modal">Continue</button> 
				</div> 
			</div> 
		</div> 
	</div>

{include file='common/footer.tpl'}
