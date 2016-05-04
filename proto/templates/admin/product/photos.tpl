{assign "title" "Edit Product"} {assign "css" ['admin/product/photos.css', 'jquery-ui/jquery-ui.css']} {include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>Edit photos for &quot;{$product.name}&quot;</h1>
				</div>
				<input type="file" id="files" name="files[]" hidden="hidden " multiple>
				<input class="btn btn-default btn-file" type="button" id="files_btn" value="Add images">
				<ul class="sortable">
				{if empty($photos)}
				{/if}
				{foreach from=$photos item=photo} 
				<li><div class="product_img" style="background-image: url(../../../images/products/{$photo.location});"></div></li>
				{/foreach} 
					<!--<li><img src="../../../images/products/product-6.jpg" alt=""></li>-->
					<!--<li><div class="product_img"></div></li>-->
					<!--<li><img src="../../../images/products/product-6.jpg" alt=""></li>-->
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
					<div class="bar" style="width: 100%;"></div>
				</div>
				<div class="done">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_add">OK</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
id = '{$id}';
</script>
<!-- FIXME -->
{assign var=js value=['product/photos.js', '../vendor/jquery-ui.min.js']} {include file='admin/common/footer.tpl'}
