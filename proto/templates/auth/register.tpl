{assign "title" "HashStore - Register"}
{include file='auth/header.tpl'}

<div id="account-wall">
  <img class="profile-img" src="../images/assets/logo2.png" alt="Online Store">
  <div class="panel-title"><h4>Create an Account</h4></div>
  <form id="form-signin">


      <div id="username" class="form-group">
        <label class="control-label" for="username-input">Username</label>
        <div class="has-feedback">
          <input name="username" type="text" class="form-control" id="username-input" data-toggle="tooltip" data-placement="top" required>
          <span class="glyphicon form-control-feedback"></span>
        </div>
      </div>

      <div id="nif" class="form-group">
        <label class="control-label" for="nif-input">NIF</label>
        <div class="has-feedback">
          <input name="nif" type="text" class="form-control" id="nif-input" data-toggle="tooltip" data-placement="top" required>
          <span class="glyphicon form-control-feedback"></span>
        </div>
      </div>

      <div id="email" class="form-group">
        <label class="control-label" for="email-input">Email</label>
        <div class="has-feedback">
          <input name="email" type="text" class="form-control" id="email-input" data-toggle="tooltip" data-placement="top" required>
          <span class="glyphicon form-control-feedback"></span>
        </div>
      </div>

      <div id="password" class="form-group">
        <label class="control-label" for="password-input">Password</label>
        <div class="has-feedback">
          <input name="password" type="password" class="form-control" id="password-input" data-toggle="tooltip" data-placement="top" required>
          <span class="glyphicon form-control-feedback"></span>
        </div>
      </div>

      <div id="password2" class="form-group">
        <label class="control-label" for="password2-input">Confirm Password</label>
        <div class="has-feedback">
          <input name="password2" type="password" class="form-control" id="password2-input" data-toggle="tooltip" data-placement="top" required>
          <span class="glyphicon form-control-feedback"></span>
        </div>
      </div>

      <button id="register-button" class="btn btn-lg btn-warning btn-block" type="submit">Register</button>
  </form>
</div>

{assign var=js value=['register.js']}

{include file='auth/footer.tpl'}
