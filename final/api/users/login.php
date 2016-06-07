<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');
  include_once($BASE_DIR . 'lib/cart_cookie.php');

if (!$_POST['email'] || !$_POST['password'] || !$_POST['remember']) {
    return_error("Both fields are required", 400);
    exit;
  }

  $email = $_POST['email'];
  $password = $_POST['password'];

  try {
    $user = isLoginCorrect($email, $password);
    if ($user === false)
    {
      return_error("Invalid user/password combination.");
    }
    else
    {
      $_SESSION['user'] = $user['iduser'];
      $_SESSION['username'] = $user['username'];
      $_SESSION['admin'] = $user['isadmin'];

      try {
        cart_cookie_to_db($user['iduser']);
      } catch (Exception $e) { }

      if (json_decode($_POST['remember']) == true)
      {
        $token_size = mcrypt_get_iv_size(MCRYPT_CAST_256, MCRYPT_MODE_CFB);
        $token = mcrypt_create_iv($token_size, MCRYPT_DEV_URANDOM);
        storeUserLoginToken($user['iduser'], $token);
        $cookie = $user['iduser'] . ':' . $token;
        $mac = hash_hmac('sha256', $cookie, SECRET_KEY);
        $cookie .= ':' . $mac;
        setcookie('rememberme', $cookie, 2147483647, $BASE_URL);
      }

    }
  } catch (PDOException $e) {
  	  error_log($e->getMessage());
      return_error("Server error");
  }

function return_error($error, $code = 422)
{
  http_response_code($code);
  echo json_encode(array('error' => $error));
  die();
}
?>