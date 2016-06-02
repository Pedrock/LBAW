{assign "title" {"HashStore - Orders Management"}}
{assign var="css" value=['my_orders.css', 'admin/main.css', 'admin/orders.css']}
{assign var="js" value=['orders.js']}
{include file='admin/common/header.tpl'}

<div class="row" id="orders">
	<div class="col-lg-12">
		<div class="content">
			<h1>Orders</h1>
			<br>
			<form id="searchBar" role="search">
				<div class="input-group">
					<input type="text" class="form-control" name="search" placeholder="Search..."{if $search} value="{$search}"{/if}>
					<span class="input-group-btn">
						<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
						<a href="orders.php" class="btn btn-default" type="button"><span class="glyphicon glyphicon-remove"></span></a>
					</span>
				</div>
			</form>
			<br>
			<div class="sort_div">
				<label class="checkbox-inline">
					<input type="checkbox" id="show_pending" {if $pending}checked{/if}> Show only pending shipments
				</label>
			</div>
			{if $n_pages > 0}
			<div class="text-center">
				<ul class="pagination pagination-sm">
					{if $page != $startpage} 
					<li><a href="?page=1{if $pending}&pending{/if}">&laquo; First</a></li>
					<li><a href="?page={$page-1}{if $pending}&pending{/if}">&lsaquo; Previous</a></li>
					{else}
					<li class="hidden-xs disabled"><a>&laquo; First</a></li>
					<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
					{/if}
					{for $p=$startpage to $endpage}
					<li{if $p == $page} class="active"{/if}><a href="?page={$p}{if $pending}&pending{/if}">{$p}</a></li>
					{/for}
					{if $page != $endpage}
					<li><a href="?page={$page+1}{if $pending}&pending{/if}">Next &rsaquo;</a></li>
					<li><a href="?page={$n_pages}{if $pending}&pending{/if}">Last &raquo;</a></li>
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
				<div class="no-results text-center">{if $search}No orders found.{else}No orders available.{/if}</div>
			{/if}
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
		</div>
	</div>
</div>

{include file='admin/common/footer.tpl'}