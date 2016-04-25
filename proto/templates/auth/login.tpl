{include file='auth/header.tpl'}

<div id="account-wall">
	<img class="profile-img" src="../images/assets/logo2.png" alt="Online Store">

	<form id="form-signin">
		<input name="email" type="text" id="login-email" class="form-control" placeholder="Email / Username" required autofocus>
		<input name="password" type="password" class="form-control" placeholder="Password" required>
		<div class="checkbox">
			<label>
				<input type="checkbox" name="remember-me"> Remember me
			</label>
		</div>
		<button id="login-button" class="btn btn-lg btn-warning btn-block" type="submit">Sign in</button>
	</form>
</div>
<a href="register.php" class="text-center new-account">Create an account </a>
<script> redirect_dest = '{$redirect_dest}'; </script> <!-- FIXME -->
{assign var=js value=['login.js']}

{include file='auth/footer.tpl'}
