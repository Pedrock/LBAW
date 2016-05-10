{assign "title" "Edit Product"}
{assign "css" ['admin/product/new.css']}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<form id="main_form" action="{$BASE_URL}api/admin/product/edit.php" method="post" enctype="multipart/form-data">
					<div id="new-product-title">
						<h1>Edit Product</h1>
						<div class="checkbox pull-right">
							<label><input type="checkbox" name="deleted" {if $product.isdeleted} checked="checked"{/if}>Hide product</label>
						</div>
					</div>
					<br>
					<a id="edit_photos" href="photos.php?id={$id}" class="btn btn-info" role="button"><span class="glyphicon glyphicon-picture"></span> Edit Photos</a>
					<br><br>
					<input type="hidden" class="form-control" id="id" name="id" value="{$product.id}">
					<input type="file" id="files" name="files[]" multiple>
					<div id="edit-product" class="row">
						<div class="col-md-6">
							<div class="col-md-12">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="name" name="name" value="{$product.name}">
								</fieldset>
							</div>
							<div class="col-md-6">
								<fieldset class="form-group">
									<label for="categories">Categories</label>
									<select multiple="multiple" size="10" class="form-control insert-category" id="categories" name="categories[]">
									{foreach from=$categories item=category}<option value="{$category.id}"{if in_array($category.id, $productcategories)} selected{/if}>{for $foo=1 to $category.level}&nbsp;{/for}{$category.name}</option>
									{/foreach}
									</select>
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="price">Price</label>
									<input type="number" class="insert-number form-control" id="price" name="price" placeholder="" value="{$product.price}">
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="stock">Stock ({$product.stock})</label>
									<input type="number" class="insert-number form-control" id="stock" name="stock" value="0">
								</fieldset>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<fieldset class="form-group">
									<label for="weight">Weight</label>
									<input type="number" class="insert-number form-control" id="weight" name="weight" placeholder="" value="{$product.weight}">
								</fieldset>
							</div>
						</div>
						<div class="col-sm-12 col-md-6">
							<fieldset class="form-group">
								<label for="description">Description</label>
								<textarea id="description" name="description" class="form-control" rows="14" cols="50" placeholder="" >{$product.description|nl2br}</textarea>
							</fieldset>
						</div>
					</div>
					<div id="row-submit" class="row">
						<div id="field-submit" class="col-xs-3">
							<fieldset class="form-group">
								<button id="btn-edit-product" class="btn btn-info" type="submit" value="Submit">Submit</button>
							</fieldset>
						</div>
					</div>

					<!-- Modal Edit -->
					<div class="modal fade" id="edit" role="dialog">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">Product edited successfully</h4>
									<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_add">OK</button>
								</div>
							</div>
						</div>
					</div>
				</form>
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

<script> id = '{$id}'; </script> <!-- FIXME -->

{assign var=js value=['product/edit.js', '../vendor/ckeditor/ckeditor.js']}

{include file='admin/common/footer.tpl'}