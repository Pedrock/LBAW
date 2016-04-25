<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');  

  if (!$_POST['email'] || !$_POST['password']) {
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
      if(isAdmin($_SESSION['user'])) // FIXME we could avoid 1 extra query if this was also returned by isLoginCorrect
        $_SESSION['admin'] = true;
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