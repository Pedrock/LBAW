{assign "title" "Edit Users"}
{assign "css" ['admin/product/new.css']}
{include file='admin/common/header.tpl'}

<form id="main_form" method="post">
	<fieldset class="form-group">
		<label for="name">Please enter the username or email of user to modify</label>
		<input type="text" class="form-control" id="user" name="user">
		<button type="submit" class="btn btn-success" id="btn_add">Add privileges</button>
		<button type="submit" class="btn btn-danger" id="btn_remove">Remove privileges</button>
	</fieldset>
</form>
<div class="modal fade" id="error" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title">Error!</h4>
			</div>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn_ok" data-dismiss="modal">OK</button>
			</div>
		</form>
	</div>
</div>

<div class="modal fade" id="ok" role="dialog">
	<div class="modal-dialog modal-sm">
		<form class="modal-content" action="javascript:void(0);">
			<div class="modal-header">
				<h4 class="modal-title">Success!</h4>
			</div>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-ok" data-dismiss="modal">OK</button>
			</div>
		</form>
	</div>
</div>
{assign var=js value=['/user/user.js']}
{include file='admin/common/footer.tpl'}