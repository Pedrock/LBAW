{include file='auth/header.tpl'}

<div class="account-wall">
  <img class="profile-img" src="../images/assets/logo2.png" alt="Online Store">
  <div class="panel-title"><h4>Create an Account</h4></div>
  <div class="form-signin">
    <div class="register-form">
      <label>Username</label>
      <input type="text" name="username" value="{$FORM_VALUES.username}" class="form-control" placeholder="Username" required autofocus="">
      <span class="field_error">{$FIELD_ERRORS.username}</span>
    </div>
    <div class="register-form">
      <label>Email</label>
      <input type="text" name="email" value="{$FORM_VALUES.email}" class="form-control" placeholder="Email" required>
      <span class="field_error">{$FIELD_ERRORS.email}</span>
    </div>
    <div class="register-form">
      <label>NIF</label>
      <input type="text" name="nif" value="{$FORM_VALUES.nif}" class="form-control" placeholder="NIF" required>
      <span class="field_error">{$FIELD_ERRORS.nif}</span>
    </div>
    <div class="register-form">
      <label>Password</label>
      <input type="password" name="password" class="form-control" placeholder="Password" required>
    </div>
    <div class="register-form">
      <label>Confirm Password</label>
      <input type="password" name="password2" class="form-control" placeholder="Confirm Password" required>
    </div>
    <button id="register-button" class="btn btn-lg btn-warning btn-block" type="submit">Register</button>
  </form>
</div>

{assign var=js value=['register.js']}

{include file='auth/footer.tpl'}
