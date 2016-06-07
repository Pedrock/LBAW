{assign "title" {"HashStore - My Favorites"}}
{assign var="css" value=['favorites.css']}
{assign var="js" value=['favorites.js']}
{assign "js" ['user/favorites.js']}
{include file='common/header.tpl'}
<div id="main-title">
	<span class="title">Favorites</span>
</div>
{assign var='list_names' value=['None']}
{assign var='list_ids' value=[NULL]}
<div id="favorites">
	<div class="panel panel-primary favoritelist" data-id="">
		<div class="panel-heading">
			<h3 class="panel-title">Uncategorized Favorites</h3>
		</div>
		<div class="panel-body">
			{assign var='cur_list' value=NULL}
			{foreach from=$favorites item=favorite}
				{if $favorite.idfavoritelist != $cur_list}
					{append var='list_ids' value=$favorite.idfavoritelist}
					{append var='list_names' value=$favorite.list}
					{if $cur_list == NULL}
						{assign var='header' value=true}
						</div></div>
						<div class="panel panel-primary">
						<div class="panel-heading"><h3 class="panel-title">Categorized Favorites</h3></div>
						<div class="panel-body">
						<div class="panel-group" id="favorites-accordion">
					{else}
						</div>
						</div>
						</div>
					{/if}
						<div class="panel panel-info favoritelist" data-id="{$favorite.idfavoritelist}">
							<div class="panel-heading">
								<a class="fav-btn btn-delete-favorite-list" href="#" data-toggle="modal" data-target="#modal_delete_list"><span class="glyphicon glyphicon-remove"></span></a>
								<h4 class="panel-title">
									<a data-toggle="collapse" class="collapsed" data-parent="#favorites-accordion" href="#collapse{$favorite.idfavoritelist}"><span class="name">{$favorite.list}</span>
									</a>
								</h4>
							</div>
							<div id="collapse{$favorite.idfavoritelist}" class="panel-collapse collapse favoritelist" data-id="{$favorite.idfavoritelist}">
								<div class="panel-body">
				{/if}
				{assign var="cur_list" value=$favorite.idfavoritelist}
				{if $favorite.idproduct}
					<div class="row favorite" data-id="{$favorite.idproduct}" data-position="{$favorite.product_position}">
						<div class="col-sm-8 product_title">
							<a href="#"><img class="fav_img"{if $favorite.photo} src="../../images/products/thumb_{$favorite.photo}"{else} src="../../images/assets/default_product.png"{/if} alt=""></a>
							<a href="../product.php?id={$favorite.idproduct}"><span>{$favorite.name}</span></a>
						</div>
						<div class="pull-right">
							<a class="fav-btn btn-move-favorite" href="#" data-toggle="modal" data-target="#modal_change"><span class="glyphicon glyphicon-sort"></span>Move</a>
							<a class="fav-btn btn-delete-favorite" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"></span>Delete</a>
						</div>
					</div>
				{/if}
			{/foreach}
			{if !$header}
							</div></div>
							<div class="panel panel-primary">
								<div class="panel-heading"><h3 class="panel-title">Categorized Favorites</h3></div>
								<div class="panel-body">
								<div class="panel-group" id="favorites-accordion"><div><div><div>
			{/if}
			</div>
			</div>
			</div>
									<div id="dummy-list" class="panel panel-info favoritelist hidden" data-id="0">
										<div class="pull-right">
											<a class="fav-btn btn-delete-favorite-list" href="#" data-toggle="modal" data-target="#modal_delete_list"><span class="glyphicon glyphicon-remove"></span></a>
										</div>
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" class="collapsed" data-parent="#favorites-accordion" href="#collapse"><span class="name">Dummy</span></a>
											</h4>
										</div>
										<div id="collapse" class="panel-collapse collapse favoritelist" data-id="dummy">
											<div class="panel-body">
											</div></div></div>
			<a id="new-category" class="btn btn-primary" data-toggle="modal" data-target="#modal_new">New List</a>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modal_change" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<form action="javascript:void(0);">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Change category</h4>
					</div>
					<div class="modal-body">
						<label for="categories_select">Select new category:</label>
						<select class="form-control" id="categories_select" name="categories_select">
							{section name=i loop=$list_ids}
								<option value="{$list_ids[i]}">{$list_names[i]}</option>
							{/section}
						</select>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">OK</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modal_new" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<form action="javascript:void(0);">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">New List</h4>
					</div>
					<div class="modal-body">
						<fieldset class="form-group">
							<label for="list_name">New list's name:</label>
							<input type="text" class="form-control" id="list_name" name="list_name">
						</fieldset>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">Add</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modal_delete_list" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<form action="javascript:void(0);">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete List</h4>
					</div>
					<div class="modal-body">
						<fieldset class="form-group">
							<p>Are you sure you want to delete this list?</p>
						</fieldset>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" id="confirm-delete">Yes</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" id="cancel-delete">No</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</div>
{include file='common/footer.tpl'}