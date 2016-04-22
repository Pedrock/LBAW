<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');  

  if (!$_POST['username'] || !$_POST['email'] || !$_POST['nif'] || !$_POST['password']) {
    return_error('All fields are mandatory');
    exit;
  }

  $email = strip_tags($_POST['email']);
  $username = strip_tags($_POST['username']);
  $nif = strip_tags($_POST['nif']);
  $password = $_POST['password'];

  var_dump($_POST);

  try {
    createUser($username, $email, $nif, $password);
  } catch (PDOException $e) {
    if (strpos($e->getMessage(), 'email') !== false)
      return_error('Username already exists');
    else
      return_error($e->getMessage());
  }

function return_error($error)
{
  http_response_code(422);
  echo json_encode(array('error' => $error));
  die();
}
?>