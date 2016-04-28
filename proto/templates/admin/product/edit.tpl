{assign "title" "Edit Product"}
{assign "css" ['admin/product/new.css']}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>Edit Product</h1>
				</div>
				<!--<form id="images_form" action="{$BASE_URL}api/admin/product/add_photos.php" method="post" enctype="multipart/form-data">
					<input type="file" id="files" name="files[]" multiple>
				</form>-->
				<form id="main_form" action="{$BASE_URL}api/admin/product/edit.php" method="post" enctype="multipart/form-data">
					<input type="hidden" class="form-control" id="id" name="id" value="{$product.id}">
					<input type="file" id="files" name="files[]" multiple>
					<div id="edit-product" class="row">
						<div class="col-md-6">
							<div class="col-md-12">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="name" name="name" value="{$product.name}">
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
							<div class="col-md-6">
								<fieldset class="form-group">
									<label for="categories">Categories</label>
									<select multiple="multiple" size="7" class="form-control insert-category" id="categories" name="categories[]">
									{foreach from=$categories item=category}
										<option value="{$category.id}" {if in_array($category.id, $productcategories)}{"selected"}{/if}>
										{for $foo=1 to $category.level}&nbsp;{/for}{$category.name}
										</option>
									{/foreach}
									</select>
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="price">Price</label>
									<input type="number" class="insert-number form-control" id="price" name="price" placeholder="" value="{$product.price}">
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="stock">Stock</label>
									<input type="number" class="insert-number form-control" id="stock" name="stock" min="1" max="500" value="{$product.stock}">
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="weight">Weight</label>
									<input type="number" class="insert-number form-control" id="weight" name="weight" placeholder="" value="{$product.weight}">
								</fieldset>
							</div>
						</div>
						<div class="col-md-6">
							<fieldset class="form-group">
								<label for="description">Description</label>
								<textarea id="description" name="description" class="form-control" rows="12" cols="50" placeholder="" >{$product.description|nl2br}</textarea>
							</fieldset>
						</div>
					</div>
					<div id="row-submit" class="row">
						<div id="field-submit" class="col-md-3">
							<fieldset class="form-group">
								<button id="btn-edit-product" class="btn btn-info" type="submit" value="Submit">Submit</button>
							</fieldset>
						</div>
						<button class="href_del btn btn-danger pull-right" data-toggle="modal" data-target="#del">
							<span class="hidden product_id">{$id}</span>
							Delete
						</button>
					</div>

					<!-- Modal Delete -->
					<div class="modal fade" id="del" role="dialog">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Delete Product</h4>
								</div>
								<div class="modal-body">
									This can't be reversed. Are you sure?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
									<button type="button" class="btn btn-danger" data-dismiss="modal" id="btn_delete">Delete</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script> id = '{$id}'; </script> <!-- FIXME -->

{assign var=js value=['product/edit.js']}

{include file='admin/common/footer.tpl'}