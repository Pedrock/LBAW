{assign "title" "Edit Users"}
{assign var="css" value=[ 'admin/main.css', 'admin/users.css']}
{include file='admin/common/header.tpl'}
<div class="row" id="orders">
	<div class="col-lg-12">
		<div class="content">
			<h1>Users</h1>
			<br>
			<form id="searchBar" role="search" method="get">
				<div class="input-group">
					<input type="text" class="form-control" name="search" placeholder="Search..."{if $search} value="{$search}"{/if}>
					<span class="input-group-btn">
						<button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
						<a href="users.php" class="btn btn-default" type="button"><span class="glyphicon glyphicon-remove"></span></a>
					</span>
				</div>
			</form>
			<br>
			<div class="sort_div">
				<label class="checkbox-inline">
					<input type="checkbox" id="show_admin" {if $adminOnly}checked{/if}> Show only Administrators
				</label>
			</div>
			{if $n_pages > 0}
			<div class="text-center">
				<ul class="pagination pagination-sm">
					{if $page != $startpage} 
					<li><a href="?page=1{if $adminOnly}&adminOnly{/if}">&laquo; First</a></li>
					<li><a href="?page={$page-1}{if $adminOnly}&adminOnly{/if}">&lsaquo; Previous</a></li>
					{else}
					<li class="hidden-xs disabled"><a>&laquo; First</a></li>
					<li class="hidden-xs disabled"><a>&lsaquo; Previous</a></li>
					{/if}
					{for $p=$startpage to $endpage}
					<li{if $p == $page} class="active"{/if}><a href="?page={$p}{if $adminOnly}&adminOnly{/if}">{$p}</a></li>
					{/for}
					{if $page != $endpage}
					<li><a href="?page={$page+1}{if $adminOnly}&adminOnly{/if}">Next &rsaquo;</a></li>
					<li><a href="?page={$n_pages}{if $adminOnly}&adminOnly{/if}">Last &raquo;</a></li>
					{else}
					<li class="hidden-xs disabled"><a>Next &rsaquo;</a></li>
					<li class="hidden-xs disabled"><a>Last &raquo;</a></li>
					{/if}
				</ul>
			</div>
			{/if}
			{if $users}
			<div class="panel panel-primary" id="accordion">
				<div class="panel-heading">
					<div class="top_row row">
						<div class="col-xs-4">Username</div>
						<div class="col-xs-5 col-sm-6">Email</div>
						<div class="col-xs-3 col-sm-2">Admin</div>
					</div>
				</div>
				<div id="accordion-container" class="panel-orders-list panel-body">
					<div class="order panel panel-primary">
						{foreach from=$users item=user}
						<a class="order-accordion loadable" data-toggle="collapse" data-parent="#accordion-container">
							<div class="user-row panel-heading" data-id="{$user.id}">
								<div class="username col-xs-4">{$user.username} </div>
								<div class="email col-xs-5 col-sm-6">{$user.email}</div>
								<div class="col-xs-3 col-sm-2">
									{if $user.admin}
										<button class="btn btn-success btn-user" type="button"><span class="glyphicon"></span></button>
									{else}
										<button class="btn btn-danger btn-user" type="button"><span class="glyphicon"></span></button>
									{/if}
								</div>
								<span class="clearfix"></span>
							</div>
						</a>
						{/foreach}
					</div>
				</div>
			</div>
			{else}
				<div class="no-results text-center">{if $search}No users found.{else}No users available.{/if}</div>
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
<div class="modal fade" id="error" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title">Error!</h4>
			</div>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn_ok" data-dismiss="modal">OK</button>
			</div>
		</form>
	</div>
</div>

<div class="modal fade" id="confirm-add" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn_ok" data-dismiss="modal">OK</button>
				<button type="button" class="btn btn-danger btn_cancel" data-dismiss="modal">Cancel</button>
			</div>
		</form>
	</div>
</div>

<div class="modal fade" id="confirm-remove" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn_ok" data-dismiss="modal">OK</button>
				<button type="button" class="btn btn-danger btn_cancel" data-dismiss="modal">Cancel</button>
			</div>
		</form>
	</div>
</div>

<div class="modal fade" id="ok" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title">Success!</h4>
			</div>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-ok" data-dismiss="modal">OK</button>
			</div>
		</form>
	</div>
</div>

{assign var=js value=['users.js']}
{include file='admin/common/footer.tpl'}