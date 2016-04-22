<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');  
  session_start();

  if (!$_POST['email'] || !$_POST['password']) {
    return_error('All fields are mandatory');
    exit;
  }

  $email = strip_tags($_POST['email']);
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
    }
  } catch (PDOException $e) {
      return_error($e->getMessage());
  }

function return_error($error)
{
  http_response_code(422);
  echo json_encode(array('error' => $error));
  die();
}
?>