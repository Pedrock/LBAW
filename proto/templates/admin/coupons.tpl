{assign "title" "Coupons"}
{assign "css" ['admin/promotions.css', 'jquery-ui/jquery-ui.css', 'jquery-ui-timepicker-addon.min.css']}
{include file='admin/common/header.tpl'}

{if $query}{assign "lnk_query" value="&search={$query}"}{/if}
{if $active}{assign "lnk_active" value="&active"}{/if}
{assign "pag_link" value="{$lnk_query}{$lnk_active}"}

<div class="row">
	<div class="col-lg-12">
		<div class="content">
			<h1 id="title">Coupons</h1>
			<a href="#" class="pull-right" id="new_promo">
				<span class="glyphicon glyphicon-plus"></span> New coupon
			</a>
			<br><br>
			<div class="sort_div">
				<label class="checkbox-inline">
				<input type="checkbox" id="active_only" {if $active}checked{/if}> Show only active coupons
				</label>
			</div>
			<br>
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
			<div class="panel panel-primary" id="accordion">
				<div class="panel-heading">
					<div class="top_row row">
						<div class="col-xs-3">Code</div>
						<div class="col-xs-3">Percentage</div>
						<div class="col-xs-3">Timespan</div>
						<div class="col-xs-3">Issuer</div>
					</div>
				</div>
				<div id="promotions_body">
					{foreach from=$coupons item=coup name=coup}
						<a href="javascript:void(0)" id="disc_{$coup.idcoupon}" data-id="{$coup.idcoupon}" class="promotion_row">
							<div class="col-xs-3 name">{$coup.code}</div>
							<div class="col-xs-3 perc">
								<span class="num">{$coup.percentage}</span>%
								{if $coup.active}
									<i class="fa fa-check" aria-hidden="true"></i>
								{/if}
							</div>
							<div class="col-xs-3 span">
								Start: <span class="start">{$coup.startdate|date_format:"%Y-%m-%d %H:%M"}</span><br>
								End: <span class="end">{$coup.enddate|date_format:"%Y-%m-%d %H:%M"}</span>
							</div>
							<div class="col-xs-3 name">{$coup.issuer}</div>
							&nbsp;
						</a>
					{/foreach}
					<div id="no_discounts">
						No coupons found
					</div>
					<!--
					<a href="javascript:void(0)" class="promotion_row promotion_row_template hidden">
						<div class="col-xs-5 name"></div>
						<div class="col-xs-2 perc">
							<span class="num">{$disc.percentage}</span>%
							<i class="fa fa-check" aria-hidden="true"></i>
						</div>
						<div class="col-xs-5 span">
							Start: <span class="start"></span><br>
							End: <span class="end"></span>
						</div>
						&nbsp;
					</a>
					-->
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
			<div class="pull-right">
				<i class="fa fa-check" aria-hidden="true"></i> Active promotion
			</div>
			&nbsp;
		</div>
	</div>
</div>


<!-- Modal Add -->
<div class="modal fade" id="new" role="dialog">
	<div class="modal-dialog modal-sm">
		<form id="form_create" class="modal-content" action="javascript:void(0);">
			<input type="hidden" name="action" value="create">
			<input type="hidden" name="id" value="{$query}">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">New coupon</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="percentage">Percentage</label>
					<input type="number" class="insert-number form-control percentage" name="percentage" placeholder="e.g. 50%" min="0" max="100" required>
				</fieldset>
				<fieldset class="form-group">
					<label for="start">Start date</label>
					<input type="text" class="datetime form-control start" name="start" required>
				</fieldset>
				<fieldset class="form-group">
					<label for="end">End date</label>
					<input type="text" class="datetime form-control end" name="end" required>
				</fieldset>
				<div class="error">
					<span class="error_title">Error! </span>
					<span class="message">
					</span>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary" id="btn_create">Create</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			</div>
		</form>
	</div>
</div>

<!-- Modal Edit -->
<div class="modal fade" id="edit" role="dialog">
	<div class="modal-dialog modal-sm">
		<form id="form_edit" class="modal-content" action="javascript:void(0);">
			<input type="hidden" name="action" value="edit">
			<input class="promo_id" type="hidden" name="id">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Edit coupon</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="product">Product</label>
					<input type="text" class="insert-number form-control product" name="product" disabled>
				</fieldset>
				<fieldset class="form-group">
					<label for="percentage">Percentage</label>
					<input type="number" class="insert-number form-control percentage" name="percentage" placeholder="e.g. 50%" min="0" max="100" required>
				</fieldset>
				<fieldset class="form-group">
					<label for="start">Start date</label>
					<input type="text" class="datetime form-control start" name="start" required>
				</fieldset>
				<fieldset class="form-group">
					<label for="end">End date</label>
					<input type="text" class="datetime form-control end" name="end" required>
				</fieldset>
				<div class="error">
					<span class="error_title">Error! </span>
					<span class="message">
					</span>
				</div>
			</div>
			<div class="modal-footer">
				<div id="del">
					<span>Delete?</span>
					<button type="button" class="pull-right btn btn-danger" id="btn_del_confirm">Confirm</button>
					<button type="button" class="pull-right btn btn-primary" id="btn_del_cancel">Cancel</button>
				</div><br>
				<button type="submit" class="btn btn-primary" id="btn_save">Save</button>
				<button type="button" class="btn btn-danger" id="btn_del">Delete</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			</div>
		</form>
	</div>
</div>
<script>
	var create = false;
	{if $create}
		create = true;
	{/if}
</script>
{assign var=js value=['coupons.js', '../vendor/jquery-ui.min.js', '../vendor/jquery-ui-timepicker-addon.min.js']}
{include file='admin/common/footer.tpl'}
