{assign "title" {"HashStore - My Favorites"}}
{assign var="css" value=['favorites.css']}
{assign var="js" value=[]}
{include file='common/header.tpl'}
<div id="main-title">
	<span class="title">Favorites</span>
</div>
<div id="favorites">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Uncategorized Favorites</h3>
		</div>
		<div class="panel-body">
			{foreach from=$favorites item=favorite}
			{if !$favorite.idproduct} {continue} {/if}
			<div class="row favorite">
				<div class="col-sm-8 product_title">
					<a href="#">
						<img class="fav_img" src="../../images/products/thumb_{$favorite.photo}" alt="">
					</a>
					<a href="../product.php?id={$favorite.idproduct}"><span>{$favorite.name}</span></a>
				</div>
				<div class="pull-right">
					<a class="fav-btn" href="#" data-toggle="modal" data-target="#<?=$id?>"><span class="glyphicon glyphicon-sort"></span>Move</a>
					<a class="fav-btn" href="#"><span class="glyphicon glyphicon-remove"></span>Delete</a>

					<!-- Modal -->
					<div class="modal fade" id="<?=$id?>" role="dialog">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Change category</h4>
								</div>
								<div class="modal-body">
									<label for="#<?=$id?>">Select new category:</label>
									<select class="form-control" id="#<?=$id?>">
										<option>None</option>
									</select>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			{/foreach}
		</div>
	</div>
</div>
{include file='common/footer.tpl'}