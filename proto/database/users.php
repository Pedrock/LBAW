  <?php
  
  function createUser($username, $email, $nif, $password) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO users(username,email,nif,password) VALUES (?, ?, ?, ?) RETURNING iduser,username,idadmin");
    $stmt->execute(array($username, $email, $nif, sha1($password)));
    return $stmt->fetch();
  }

  function isLoginCorrect($email, $password) {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser, username, isadmin FROM Users WHERE (username = ? OR LOWER(email) = LOWER(?)) AND password = ?;");
    $stmt->execute(array($email, $email, sha1($password)));
    return $stmt->fetch();
  }

  function getUserInfo($user_id) {
    global $conn;
    $stmt = $conn->prepare("SELECT username, isadmin FROM Users WHERE idUser = ?;");
    $stmt->execute(array($user_id));
    return $stmt->fetch();
  }

  function usernameExists($username)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser FROM Users WHERE LOWER(username) = LOWER(?);");
    $stmt->execute(array($username));
    return $stmt->fetch() !== false;
  }

  function emailExists($email)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser FROM Users WHERE LOWER(email) = LOWER(?);");
    $stmt->execute(array($email));
    return $stmt->fetch() !== false;
  }

  function storeUserLoginToken($user_id, $token)
  {
    global $conn;
    $stmt = $conn->prepare('INSERT INTO login_tokens(idUser,token) VALUES (?,?)');
    $stmt->execute(array($user_id, bin2hex($token)));
  }

  function isValidLoginToken($user_id, $token)
  {
    global $conn;
    $stmt = $conn->prepare('SELECT token FROM login_tokens WHERE idUser = ? AND token = ?');
    $stmt->execute(array($user_id, bin2hex($token)));
    return $stmt->fetch();
  }

  function deleteLoginToken($user_id, $token)
  {
    global $conn;
    $stmt = $conn->prepare('DELETE FROM login_tokens WHERE idUser = ? AND token = ?');
    $stmt->execute(array($user_id, bin2hex($token)));
  }

?>
