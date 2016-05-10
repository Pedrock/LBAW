{assign "title" "New Product"}
{assign "css" ['admin/product/new.css']}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>New Product</h1>
				</div>
				<br>
				<!--<form id="images_form" action="{$BASE_URL}api/admin/product/add_photos.php" method="post" enctype="multipart/form-data">-->
				</form>
				<form id="main_form" action="{$BASE_URL}api/admin/product/new.php" method="post" enctype="multipart/form-data">
					<!--<input type="file" id="files" name="files[]" multiple> -->
					<div id="new-product" class="row">
						<div class="col-md-6">
							<div class="col-md-12">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="name" name="name">
								</fieldset>
								<!--<form id="images_form" action="../../api/admin/product_photos.php" method="post" enctype="multipart/form-data">
									<fieldset class="form-group">
											<input class="btn btn-default btn-file"type="button" id="files_btn" value="Browse">
										<label class="control-label">Add Images</label>
										<div class="drop_zone">
										</div>
									</fieldset>
								</form>-->
							</div>
							<div class="col-sm-6">
								<fieldset class="form-group">
									<label for="categories">Categories</label>
									<select multiple="multiple" size="10" class="form-control insert-category" id="categories" name="categories[]">
									{foreach from=$categories item=category}
										<option value="{$category.id}">{for $foo=1 to $category.level}&nbsp;{/for}{$category.name}</option>
									{/foreach}
									</select>
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="price">Price</label>
									<input type="number" class="insert-number form-control" id="price" name="price" placeholder="" min="0">
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="stock">Stock</label>
									<input type="number" class="insert-number form-control" id="stock" name="stock" min="0" value="1">
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="weight">Weight</label>
									<input type="number" class="insert-number form-control" id="weight" name="weight" placeholder="" min="0">
								</fieldset>
							</div>
						</div>
						<div class="col-sm-12 col-md-6">
							<fieldset class="form-group">
								<label for="description">Description</label>
								<textarea id="description" name="description" class="form-control" rows="14" cols="50"></textarea>
							</fieldset>
						</div>
					</div>
					<div id="row-submit" class="row">
						<div id="field-submit" class="col-md-3">
							<fieldset class="form-group">
								<button id="btn-new-product" class="btn btn-info" type="submit" value="Submit">Submit</button>
							</fieldset>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="confirmation" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Product created successfully</h4>
				<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_add">OK</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="error" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">There was an error</h4>
			</div>
			<div class="modal-body">
				<span id="error_description">There was an error creating the product</span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_ok">OK</button>
			</div>
		</div>
	</div>
</div>

{assign var=js value=['product/new.js', '../vendor/ckeditor/ckeditor.js']}

{include file='admin/common/footer.tpl'}