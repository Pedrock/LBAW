{assign "title" "New Product"}
{include file='admin/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="new-product_content tab-content">
			<div id="new_address" class="tab-pane fade in active">
				<div id="new-product-title">
					<h1>New Product</h1>
				</div>
				<form>
					<div id="new-product" class="row">
						<div class="col-md-6">
							<div class="col-md-12">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="name">
								</fieldset>
								<fieldset class="form-group">
									<span class="btn btn-default btn-file">
										Browse <input type="file">
									</span>
									<label class="control-label">Select Images</label>
								</fieldset>
							</div>
							<div class="col-md-6">
								<fieldset class="form-group">
									<label for="country">Category</label>
									<select multiple="multiple" size="7" class="form-control insert-category" id="country">
									{foreach from=$categories item=category}
										<option value="{$category.id}">{for $foo=1 to $category.level}&nbsp;{/for}{$category.name}</option>
									{/foreach}
									</select>
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="name">Price</label>
									<input type="number" class="insert-number form-control" id="addr2" placeholder="">
								</fieldset>
							</div>
							<div class="col-md-3">
								<fieldset class="form-group">
									<label for="name">Stock</label>
									<input type="number" class="insert-number form-control" id="city" min="1" max="500" value="1">
								</fieldset>
							</div>
						</div>
						<div class="col-md-6">
							<fieldset class="form-group">
								<label for="name">Description</label>
								<textarea class="form-control" rows="12" cols="50"></textarea>
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
{include file='admin/footer.tpl'}