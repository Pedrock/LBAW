{include file='auth/header.tpl'}

<div id="account-wall">
  <img class="profile-img" src="../images/assets/logo2.png" alt="Online Store">
  <div class="panel-title"><h4>Create an Account</h4></div>
  <form id="form-signin">
      <label for="username">Username</label>
      <input id="username" type="text" name="username" value="{$FORM_VALUES.username}" class="form-control" placeholder="Username" required autofocus="">
      <span class="field_error">{$FIELD_ERRORS.username}</span>

      <label for="email">Email</label>
      <input id="email" type="text" name="email" value="{$FORM_VALUES.email}" class="form-control" placeholder="Email" required>
      <span class="field_error">{$FIELD_ERRORS.email}</span>

      <label for="nif">NIF</label>
      <input id="nif" type="text" name="nif" value="{$FORM_VALUES.nif}" class="form-control" placeholder="NIF" required>
      <span class="field_error">{$FIELD_ERRORS.nif}</span>

      <label for="password">Password</label>
      <input id="password" type="password" name="password" class="form-control" placeholder="Password" required>

      <label for="password2">Confirm Password</label>
      <input id="password2" type="password" name="password2" class="form-control" placeholder="Confirm Password" required>

      <button id="register-button" class="btn btn-lg btn-warning btn-block" type="submit">Register</button>
  </form>
</div>

{assign var=js value=['register.js']}

{include file='auth/footer.tpl'}
