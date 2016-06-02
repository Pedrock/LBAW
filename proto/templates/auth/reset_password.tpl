{assign "title" "HashStore - Recover Password"}
{include file='auth/header.tpl'}

<div id="account-wall">
	<a href="index.php">
		<img class="profile-img" src="{$BASE_URL}images/assets/logo2.png" alt="Online Store">
	</a>
	{if $error}
		<div id="reset_error">
			{$error}
			<br><br>
			<a href="recover_password.php" class="recover-pw">Recover password</a>
		</div>
	{else}
		<div class="panel-title"><h4>Reset Password</h4></div>
		<div id="error" class="alert alert-danger slide in">
			<a href="#" class="close">&times;</a>
			<strong>Error!</strong>
			<span id="msg">
			</span>
		</div>
		<div id="success" class="alert alert-success slide in">
			<span id="msg">
				Password reset successfully. You can now login with the new password.
			</span>
		</div>
		<form id="form-signin">
			<input name="password" type="password" id="password" class="form-control" placeholder="New Password" required autofocus>
			<input name="password2" type="password" id="password2" class="form-control" placeholder="Confirm Password" required>
			<button id="reset_btn" class="btn btn-lg btn-warning btn-block" type="submit">Reset</button>
		</form>
	{/if}
	<a href="login.php">
		<button id="login_btn" class="btn btn-lg btn-success btn-block" type="button">Login</button>
	</a>
</div>
<script>
	id = '{$id}';
	token = '{$token}';
</script>
{assign var=js value=['reset_password.js']}
{include file='auth/footer.tpl'}
