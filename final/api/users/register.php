<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');
  include_once($BASE_DIR .'lib/nif.php');

if (!$_POST['username'] || !$_POST['email'] || !$_POST['nif'] || !$_POST['password']) {
    return_error('All fields are mandatory');
  }

  $email = trim($_POST['email']);
  $username = trim($_POST['username']);
  $nif = trim($_POST['nif']);
  $password = $_POST['password'];

  $errors = array();

  // Check email
  if (!filter_var($email, FILTER_VALIDATE_EMAIL))
  {
    $errors['email'] = "Invalid email";
  }
  else if (emailExists($email))
    $errors['email'] = "Email already in use";

  // Check username
  if (!preg_match("/^[A-z0-9_-]{3,16}$/", $username))
    $errors['username'] = "Usernames should have between 3 and 16 characters and can contain letters, numbers, underscores and dashes";
  else if (usernameExists($username))
    $errors['username'] = "Username already in use";

  // Check password
  if (strlen($password) < 6)
    $errors['password'] = "The password must have at least 6 characters";

  // Check NIF
  if (!validNIF($nif))
  {
    $errors['nif'] = "Invalid NIF";
  }

  if (!empty($errors))
  {
    return_errors($errors);
  }

  try {
    $user = createUser($username, $email, $nif, $password);
    $_SESSION['user'] = $user['iduser'];
    $_SESSION['username'] = $user['username'];
    $_SESSION['admin'] = $user['isadmin'];

    cart_cookie_to_db($user['iduser']);
    
    http_response_code(201);
  } catch (PDOException $e) {
      return_error("An error occurred while creating your account. Please try again.");
  }

function return_error($error)
{
  http_response_code(422);
  echo json_encode(array('error' => $error));
  die();
}

function return_errors($error)
{
  http_response_code(422);
  echo json_encode(array('errors' => $error));
  die();
}
?>