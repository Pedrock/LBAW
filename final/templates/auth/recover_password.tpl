{assign "title" "HashStore - Recover Password"}
{include file='auth/header.tpl'}

<div id="account-wall">
	<a href="index.php">
		<img class="profile-img" src="{$BASE_URL}images/assets/logo2.png" alt="Online Store">
	</a>
	 <div class="panel-title"><h4>Recover Password</h4></div>
	<div id="error" class="alert alert-danger slide in">
		<a href="#" class="close">&times;</a>
		<strong>Error!</strong>
		<span class="msg">
		</span>
	</div>
	<div id="success" class="alert alert-success slide in">
		<span class="msg">
			You will receive an email with instructions on how to reset your password.
		</span>
	</div>
	<form id="form-signin">
		<input name="email" type="text" id="login-email" class="form-control" placeholder="Email" required autofocus>
		<button id="login-button" class="btn btn-lg btn-warning btn-block" type="submit">Recover</button>
	</form>
</div>
<a href="register.php" class="text-center new-account">Create an account</a>
<a href="login.php" class="text-center new-account">Login</a>

{assign var=js value=['recover_password.js']}
{include file='auth/footer.tpl'}
