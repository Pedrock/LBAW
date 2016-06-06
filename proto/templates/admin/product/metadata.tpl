{assign "title" "Edit Product"}
{assign "css" ['admin/product/metadata.css']}
{include file='admin/common/header.tpl'}

<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>
						<a href="edit.php?id={$id}">
							<span class="glyphicon glyphicon-menu-left"></span>
						</a>
						Edit metadata for &quot;{$product.name}&quot;
					</h1>
					<a href="metadata_categories.php?id={$id}" class="href_manage"">
						<span class="glyphicon glyphicon-pencil"></span> &nbsp; Manage categories
					</a>
					<a href="javascript:void(0)" class="href_add"">
						<span class="glyphicon glyphicon-plus"></span> &nbsp; Add metadata
					</a>
					<br><br>
				</div>
				<div id="metadata_container">
					{foreach from=$metadata item=data}
						<div class="item" id="meta_{$data.idcategory}" data-id="{$data.idcategory}">
							<button class="href_del pull-right">
								<span class="glyphicon glyphicon-trash"></span>
							</button>
							<button class="href_edit pull-right">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
							<span class="category">{$data.category}</span><br>
							<span class="description">{$data.description}</span>
						</div>
					{/foreach} 
					<div id="empty" {if !empty($metadata)} style="display: none;" {/if}>
						This product has no metadata
					</div>
					<div class="template hidden">
							<button class="href_del pull-right">
								<span class="glyphicon glyphicon-trash"></span>
							</button>
							<button class="href_edit pull-right">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
							<span class="category"></span><br>
							<span class="description"></span>
						</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>

<!-- Modal Add -->
<div class="modal fade" id="add" role="dialog">
	<div class="modal-dialog modal-sm">
		<form id="form_add" class="modal-content" action="javascript:void(0);">
			<input type="hidden" name="product" value="{$id}">
			<input type="hidden" name="action" value="create">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Add metadata</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="name">Category</label>
					<input type="text" class="form-control filter" placeholder="Filter">
					<div id="categories">
						{foreach from=$categories item=cat}
							<div class="radio">
								<label><input id="cat_{$cat.id}" class="cat_radio" type="radio" name="cat" value="{$cat.id}">
								<span class="cat_name">{$cat.name}</span></label>
							</div>
						{/foreach}
					</div>
					<div id="no_cats_found">
						No categories found
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label for="description">Description</label>
					<input type="text" class="form-control description" name="description" required>
				</fieldset>
			</div>
			<div class="modal-footer">
				<div class="error">
					<span class="err">Error!</span>
					<span class="msg">There was an error</span>
				</div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" id="btn_add">Add</button>
			</div>
		</form>
	</div>
</div>

<!-- Modal Delete -->
<div class="modal fade" id="del" role="dialog">
	<div class="modal-dialog modal-sm">
		<form id="form_delete" class="modal-content" action="javascript:void(0);">
			<input type="hidden" class="cat_id" name="cat">
			<input type="hidden" name="product" value="{$id}">
			<input type="hidden" name="action" value="delete">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Delete &quot;<span class="category_name">Category Name</span>&quot;</h4>
			</div>
			<div class="modal-body">
				This can't be reversed. Are you sure?
			</div>
			<div class="modal-footer">
				<div class="error">
					<span class="err">Error!</span>
					<span class="msg">There was an error</span>
				</div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-danger" id="btn_delete">Delete</button>
			</div>
		</form>
	</div>
</div>

<!-- Modal Edit -->
<div class="modal fade" id="edit" role="dialog">
	<div class="modal-dialog modal-sm">
		<form id="form_edit" class="modal-content" action="javascript:void(0);">
			<input type="hidden" class="cat_id" name="cat">
			<input type="hidden" name="product" value="{$id}">
			<input type="hidden" name="action" value="edit">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Edit &quot;<span class="category_name">Category Name</span>&quot;</h4>
			</div>
			<div class="modal-body">
				<fieldset class="form-group">
					<label for="name">Description</label>
					<input type="text" class="form-control description" name="description" required>
				</fieldset>
			</div>
			<div class="modal-footer">
				<div class="error">
					<span class="err">Error!</span>
					<span class="msg">There was an error</span>
				</div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" id="btn_edit">Save</button>
			</div>
		</form>
	</div>
</div>

{assign var=js value=['product/metadata.js']}
{include file='admin/common/footer.tpl'}
