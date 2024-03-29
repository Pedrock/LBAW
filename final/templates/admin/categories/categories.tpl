{assign "title" "Categories"}
{assign "css" ['admin/categories.css']}
{include file='admin/common/header.tpl'}
<div class="row">
	<div class="col-lg-12">
		<div class="content tab-content">
			<div id="manage-categories" class="tab-pane fade in active">
				<div id="title">
					<h1>Categories</h1><br>
				</div>
				<a href="javascript:void(0,root,0)" class="href_add pull-right" id="add_new_on_root" data-toggle="modal" data-target="#add">
						<span class="hidden category_id">0</span>
						<span class="glyphicon glyphicon-plus"></span> &nbsp; New category
				</a>
				<br>
				<br>
				<div id="categories-list" class="list-group list-group-root well">
					{assign var="cur_level" value=0}
					{assign var="prev_id" value=0}
					{foreach from=$categories item=category}
						{if $category.level gt $cur_level}
							<div class="list-group collapse" id="{$prev_id}">
							{assign var="cur_level" value=$category.level}
						{elseif $category.level lt $cur_level}
							{while $category.level lt $cur_level}
								</div>
								{assign var="cur_level" value=$cur_level-1}
							{/while}
						{/if}
							{assign var="n" value=25}
							{$color=-255/($n - 1)*$category.level + 255}
							<a href="#{$category.id}" class="category list-group-item collapsed clearfix" data-toggle="collapse" id="cat_{$category.id}" data-id="{$category.id}" style="background-color: rgb({$color|round:0},{$color|round:0},{$color|round:0});">
								<span class="icon {if $category.numChilds eq 0}hidden{/if}"></span>
								<span class="categ_name">{$category.name}</span>
								<span class="categ_num_child"></span>
								<span class="pull-right">
									<button class="href_add" data-toggle="modal" data-target="#add">
										<span class="hidden category_id">{$category.id}</span>
										<span class="glyphicon glyphicon-plus"></span>
									</button>
									<button class="href_edit" data-toggle="modal" data-target="#edit">
										<span class="hidden category_id">{$category.id}</span>
										<span class="hidden category_name">{$category.name}</span>
										<span class="hidden category_parent">{$category.parent}</span>
										<span class="glyphicon glyphicon-pencil"></span>
									</button>
									<button class="href_del" data-toggle="modal" data-target="#del">
										<span class="hidden category_id">{$category.id}</span>
										<span class="hidden category_name">{$category.name}</span>
										<span class="glyphicon glyphicon-trash"></span>
									</button>
								</span>
							</a>
						{assign var="prev_id" value=$category.id}
					{/foreach}
				</div>
				{while $cur_level > 0}
					</div>
					{assign var="cur_level" value=$cur_level-1}
				{/while}

				<!-- Modal Add -->
				<div class="modal fade" id="add" role="dialog">
					<div class="modal-dialog modal-sm">
						<form class="modal-content" action="javascript:void(0);">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">New subcategory</h4>
							</div>
							<div class="modal-body">
								<fieldset class="form-group">
									<label for="name">Name</label>
									<input type="text" class="form-control" id="add_name" name="name">
								</fieldset>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary" data-dismiss="modal" id="btn_add">Create</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
							</div>
						</form>
					</div>
				</div>
				
				<!-- Modal Edit -->
				<div class="modal fade" id="edit" role="dialog">
					<div class="modal-dialog modal-sm">
						<form class="modal-content" action="javascript:void(0);">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Edit &quot;<span class="category_name">Category Name</span>&quot;</h4>
							</div>
							<div class="modal-body">
								<label for="name">Name</label>
								<input type="text" class="form-control" id="edit_name" name="name">
								<br>
								<label for="edit_parent">Select new parent:</label>
								<select class="form-control" id="edit_parent">
									<option value="0">Root</option>
									{foreach from=$categories item=category_2}<option value="{$category_2.id}">{for $foo=0 to $category_2.level}&nbsp;{/for}{$category_2.name}</option>
									{/foreach}
								</select>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary" data-dismiss="modal" id="btn_edit">OK</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
							</div>
						</form>
					</div>
				</div>
				
				<!-- Modal Delete -->
				<div class="modal fade" id="del" role="dialog">
					<div class="modal-dialog modal-sm">
						<form class="modal-content" action="javascript:void(0);">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Delete &quot;<span class="category_name">Category Name</span>&quot;</h4>
							</div>
							<div class="modal-body">
								This can't be reversed. Are you sure?
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
								<button type="submit" class="btn btn-danger" data-dismiss="modal" id="btn_delete">Delete</button>
							</div>
						</form>
					</div>
				</div>

				<!-- Modal Error -->
				<div class="modal fade" id="error" role="dialog">
					<div class="modal-dialog modal-sm">
						<form class="modal-content" action="javascript:void(0);">
							<div class="modal-header">
								<h4 class="modal-title">There was an error</h4>
							</div>
							<div class="modal-body">
								<span id="error_description"></span>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_ok">OK</button>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>

{assign var=js value=['categories.js']}

{include file='admin/common/footer.tpl'}