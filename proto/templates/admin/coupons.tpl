{assign "title" "Coupons"}
{assign "css" ['admin/coupons.css', 'jquery-ui/jquery-ui.css', 'jquery-ui-timepicker-addon.min.css']}
{include file='admin/common/header.tpl'}

{if $query}{assign var="lnk_query" value="&search={$query}"}{/if}
{if $active}{assign var="lnk_active" value="&active"}{/if}
{assign var="pag_link" value="{$lnk_query}{$lnk_active}"}

<div class="row">
	<div class="col-lg-12">
		<div class="content">
			<h1 id="title">Coupons</h1>
			<a href="#" class="pull-right" id="new_coupon">
				<span class="glyphicon glyphicon-plus"></span> New coupon
			</a>
			<span class="clearfix"></span>
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
				<div id="coupons_body">
					{foreach from=$coupons item=coup name=coup}
						<a href="javascript:void(0)" data-id="{$coup.idcoupon}" class="coupon_row disc_{$coup.idcoupon}">
							<div class="col-xs-3 code">{$coup.code}</div>
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
							<div class="col-xs-3 issuer">{$coup.issuer}</div>
							<span class="clearfix"></span>
						</a>
					{/foreach}
					<div id="no_discounts">
						No coupons found
					</div>
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
				<i class="fa fa-check" aria-hidden="true"></i> Active coupon
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
				<h4 class="modal-title">New Coupon</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="code">Code</label>
					<input type="text" class="insert-number form-control code" name="code" value="">
				</fieldset>
				<fieldset class="form-group">
					<label for="percentage">Percentage</label>
					<input type="number" class="insert-number form-control percentage" name="percentage" placeholder="e.g. 50%" min="1" max="99" required>
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
			<input class="coupon_id" type="hidden" name="id">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Edit coupons</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="code">Code</label>
					<input type="text" class="insert-number form-control code" name="code">
				</fieldset>
				<fieldset class="form-group">
					<label for="percentage">Percentage</label>
					<input type="number" class="insert-number form-control percentage" name="percentage" placeholder="e.g. 50%" min="1" max="99" required>
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
				<div id="del" class="text-right">
					<span class="pull-left">Delete?</span>
					<button type="button" class="btn btn-danger" id="btn_del_confirm">Confirm</button>
					<button type="button" class="btn btn-default" id="btn_del_cancel">Cancel</button>
				</div><br>
				<button type="submit" class="btn btn-success" id="btn_save">Save</button>
				<button type="button" class="btn btn-danger" id="btn_del">Delete</button>
				<button type="button" class="btn btn-default" id="btn_cancel" data-dismiss="modal">Cancel</button>
			</div>
		</form>
	</div>
</div>
<script>
	var query = '{$query}';
	var create = {$create|json_encode};
</script>
{assign var=js value=['../vendor/jquery-ui.min.js', '../vendor/jquery-ui-timepicker-addon.min.js', 'coupons.js']}
{include file='admin/common/footer.tpl'}
