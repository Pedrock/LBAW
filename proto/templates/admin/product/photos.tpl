{assign "title" "Edit Product"} {assign "css" ['admin/product/photos.css', 'jquery-ui/jquery-ui.css']} {include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>
						<a href="edit.php?id={$id}">
							<span class="glyphicon glyphicon-menu-left"></span>
						</a>
						Edit photos for &quot;{$product.name}&quot;</h1>
				</div>
				<input type="file" id="files" name="files[]" hidden="hidden " multiple>
				<input class="btn btn-default btn-file" type="button" id="files_btn" value="Add photos">
				{if empty($photos)}
					<span class="no_photos">&nbsp;The product has no photos</span>
				{/if}
				<ul class="sortable">
				{foreach from=$photos item=photo} 
				<li class="product_img" id="img_{$photo.photo_order}" style="background-image: url(../../../images/products/{$photo.location});">
					<div class="del">DEL<span class="hidden">{$photo.photo_order}</span></div>
				</li>
				{/foreach} 
				</ul>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="uploading" role="dialog" data-backdrop="static">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<span id="uploading_header"><h4>Uploading photos... <span id="uploaded_num">0</span>/<span id="total_num">0</span></h4>
				</span>
				<span id="error"></span>
			</div>
			<div class="modal-body">
				<div class="progress progress-striped active">
					<div class="bar" style="width:50%;"></div>
				</div>
				<div class="done">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_add">OK</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="editing" role="dialog" data-backdrop="static">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<span id="editing_header"><h4>Changing order...</h4>
				</span>
				<span id="editing_error"></span>
			</div>
			<div class="modal-body">
				<div class="done">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_reload">OK</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Delete -->
<div class="modal fade" id="del" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Delete Photo</h4>
			</div>
			<div class="modal-body">
				<span class="confirmation">This can't be reversed. Are you sure?</span>
				<span class="deleting">Deleting...</span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-danger" id="btn_delete">Delete</button>
			</div>
		</div>
	</div>
</div>
<script>
id = '{$id}';
</script>
<!-- FIXME -->
{assign var=js value=['product/photos.js', '../vendor/jquery-ui.min.js']} {include file='admin/common/footer.tpl'}
