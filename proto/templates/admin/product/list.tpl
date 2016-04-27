{assign "title" "Edit Product"}
{assign "css" ['admin/product/list.css']}
{include file='admin/common/header.tpl'}

<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>Edit Product</h1>
				</div>
				<form id="form-edit-product" role="search">
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{$category_name}&nbsp;<span class="caret"></span></button>
							<ul class="dropdown-menu dropdown-menu-right">
								<li><a href="list.php">Any</a></li>
								{foreach from=$categories item=cat}
									<li><a href="list.php?category={$cat.id}">{for $foo=0 to $cat.level}&nbsp;{/for}{$cat.name}</a></li>
								{/foreach}
							</ul>
						</div>
						<input type="text" class="form-control" name="search" placeholder="Search...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
						</span>
					</div>
				</form>
			</div>
				<div class="seleciona sort_div pull-left">
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
							<li><a href="?page=1&category={$category}">&laquo; First</a></li>
							<li><a href="?page={$page-1}&category={$category}">&lsaquo; Previous</a></li>
						{else}
							<li class="hidden-xs disabled"><a>&laquo; First</a></li>
							<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
						{/if}

						{for $p=$startpage to $endpage}
							<li{if $p == $page} class="active"{/if}><a href="?page={$p}&category={$category}">{$p}</a></li>
						{/for}

						{if $page != $endpage}
							<li><a href="?page={$page+1}&category={$category}">Next &rsaquo;</a></li>
							<li><a href="?page={$n_pages}&category={$category}">Last &raquo;</a></li>
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
								<div class="thumbnail">
									<a href="edit.php?id={$product.id}" class="link-p">
										<img src="{$BASE_URL}images/products/{$product.photo}" alt="">
									</a>
									<div class="caption">
										<h4><a href="product.php?id={$product.id}">{$product.name}</a></h4>
										&nbsp;
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
								<li><a href="?page=1&category={$category}">&laquo; First</a></li>
								<li><a href="?page={$page-1}&category={$category}">&lsaquo; Previous</a></li>
							{else}
								<li class="hidden-xs disabled"><a>&laquo; First</a></li>
								<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
							{/if}

							{for $p=$startpage to $endpage}
								<li{if $p == $page} class="active"{/if}><a href="?page={$p}&category={$category}">{$p}</a></li>
							{/for}

							{if $page != $endpage}
								<li><a href="?page={$page+1}&category={$category}">Next &rsaquo;</a></li>
								<li><a href="?page={$n_pages}&category={$category}">Last &raquo;</a></li>
							{else}
								<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
								<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
							{/if}
						</ul>
					</div>
				{else}
					<br><br>
				{/if}
			</div>
	</div>
</div>

{assign var=js value=['product/list.js']}

{include file='admin/common/footer.tpl'}