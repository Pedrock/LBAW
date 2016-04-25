<?php
  
  function createUser($username, $email, $nif, $password) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO users(username,email,nif,password) VALUES (?, ?, ?, ?) RETURNING iduser");
    $stmt->execute(array($username, $email, $nif, sha1($password)));
  }

  function isLoginCorrect($email, $password) {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser FROM Users WHERE (username = ? OR LOWER(email) = LOWER(?)) AND password = ?;");
    $stmt->execute(array($email, $email, sha1($password)));
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

  function isAdmin($userid) {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser FROM Users WHERE idUser = ? AND isAdmin");
    $stmt->execute(array($userid));
    return $stmt->fetch() !== false;
  }
?>
