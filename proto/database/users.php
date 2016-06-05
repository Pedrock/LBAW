<?php

  function createUser($username, $email, $nif, $password) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO users(username,email,nif,password) VALUES (?, ?, ?, ?) RETURNING iduser,username,isadmin");
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

  function getPurchaseHistory($user_id,$limit,$page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idOrder AS id, to_char(orderDate,'YYYY-MM-DD HH24:MI') AS orderDate, totalPrice AS price, COUNT(idOrder) OVER () AS total_count
      FROM Orders 
      WHERE idUser = ? 
      ORDER BY idOrder DESC 
      LIMIT ? OFFSET ?;");
    $stmt->execute(array($user_id,$limit,$offset));
    return $stmt->fetchAll();
  }

  function getInfoPurchaseHistory($user_id, $order_id)
  {
    global $conn;
    $stmt1 = $conn->prepare(
      "SELECT order_status AS status, totalprice, shipping_name, shipping_phone, shipping_address1, shipping_address2, shipping_city, shipping_zip1, shipping_zip2, billing_name, billing_phone, billing_address1, billing_address2, billing_city, billing_zip1, billing_zip2, 
        Coupon.percentage AS coupon_discount
            FROM Orders 
            LEFT JOIN Coupon USING(idcoupon)
            WHERE idOrder = ? AND Orders.idUser = ?;");

    $stmt2 = $conn->prepare(
      "SELECT ProductOrder.idProduct AS id, product_status, location AS photo, ProductOrder.quantity, name, ProductOrder.price
                FROM ProductOrder
                LEFT JOIN Orders USING(idOrder)
                INNER JOIN Product USING(idProduct)
                LEFT JOIN Photo ON ProductOrder.idProduct = Photo.idProduct AND photo_order = 1
          WHERE idOrder = ? AND idUser = ?;");

    $conn->beginTransaction();
    $stmt1->execute(array($order_id, $user_id));
    $stmt2->execute(array($order_id, $user_id));
    $conn->commit();

    $order_info = $stmt1->fetch();
    $order_products = $stmt2->fetchAll();
    return array($order_info, $order_products);
  }

  function addToFavorites($user_id, $product_id)
  {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO Favorite(idProduct, idUser, idFavoriteList) 
      VALUES (?, ?, NULL);");
    $stmt->execute(array($product_id,$user_id));
  }

  function removeFromFavorites($user_id, $product_id)
  {
    global $conn;
    $stmt = $conn->prepare("DELETE FROM Favorite WHERE idProduct = ? AND idUser = ?;");
    $stmt->execute(array($product_id,$user_id));
  }

  function moveFavorite($user_id, $product_id, $new_list)
  {
    global $conn;
    $stmt = $conn->prepare("UPDATE Favorite SET idFavoriteList = ? WHERE idProduct = ? AND idUser = ?;");
    $stmt->execute(array($new_list,$product_id,$user_id));
  }

  function getUserFavorites($user_id)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT idfavoritelist, FavoriteList.name AS list, Product.idproduct, Product.name, location AS photo, product_position
        FROM FavoriteList
        FULL JOIN Favorite USING(idFavoriteList)
        LEFT JOIN Product USING(idProduct) 
        LEFT JOIN Photo ON Favorite.idProduct = Photo.idProduct AND photo_order = 1
        WHERE FavoriteList.idUser = ? OR Favorite.idUser = ?
        ORDER BY FavoriteList.idFavoriteList NULLS FIRST,product_position;");
    $stmt->execute(array($user_id, $user_id));
    return $stmt->fetchAll();
  }

  function createFavoriteList($user_id, $list_name)
  {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO FavoriteList(idUser, name) VALUES (?, ?) RETURNING idfavoritelist;");
    $stmt->execute(array($user_id, $list_name));
    return $stmt->fetch()['idfavoritelist'];
  }

  function deleteFavoriteList($user_id, $list_id)
  {
    global $conn;
    $stmt = $conn->prepare("DELETE FROM FavoriteList WHERE idUser = ? and idfavoritelist = ?;");
    $stmt->execute(array($user_id, $list_id));
  }
  
  function getUserAddresses($user_id)
  {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idaddress AS id, Address.name, address1, address2, nif, (code1||'-'||code2) AS zipcode, City.name AS city, phonenumber
        FROM Users
        FULL JOIN Address USING (idUser)
        LEFT JOIN ZipCode USING (idZipCode)
        LEFT JOIN City USING (idCity)
        WHERE idUser = ?;");
    $stmt->execute(array($user_id));
    return $stmt->fetchAll();
  }

  function getUserProfile($user_id){
    global $conn;
    $stmt = $conn->prepare("SELECT email, nif FROM Users WHERE idUser = ?;");
    $stmt->execute(array($user_id));
    return $stmt->fetch();
  }

  function updateUserProfile($user_id, $new_email, $new_nif){
    global $conn;
    $stmt = $conn->prepare("UPDATE Users SET email = ?, nif = ? WHERE idUser = ?;");
    $stmt->execute(array($new_email, $new_nif, $user_id));
    return $stmt->fetch();
  }

  function updateUserProfileAndPassword($user_id, $email, $nif, $current_password, $new_password)
  {
    global $conn;
    $stmt = $conn->prepare("UPDATE Users SET password = ?, email = ?, nif = ? WHERE idUser = ? AND password = ?;");
    $stmt->execute(array(sha1($new_password), $email, $nif, $user_id, sha1($current_password)));
    return $stmt->fetch();
  }

  function getUserAddress($user_id, $address_id)
  {
    global $conn;
    $stmt = $conn->prepare(
        "SELECT idaddress AS id, Address.name, address1, address2, (code1||'-'||code2) AS zipcode, City.name AS city, phonenumber
        FROM Address
        LEFT JOIN ZipCode USING (idZipCode)
        LEFT JOIN City USING (idCity)
        WHERE idUser = ? AND idAddress = ?;");
    $stmt->execute(array($user_id, $address_id));
    return $stmt->fetch();
  }

  function getCity($zip1, $zip2)
  {
    global $conn;
    $stmt = $conn->prepare(
        "SELECT City.name AS city
        FROM ZipCode
        INNER JOIN City USING (idCity)
        WHERE code1 = ? AND code2 = ?");
    $stmt->execute(array($zip1, $zip2));
    return $stmt->fetch();
  }

  function startPasswordRecovery($email, $token) {
    global $conn;
    $stmt = $conn->prepare("SELECT create_recovery_token(?, ?)");
    $stmt->execute(array($email, $token));
    return $stmt->fetch()['create_recovery_token'];
  }

  function validResetToken($user_id, $token) {
    global $conn;
    $stmt = $conn->prepare("SELECT iduser as id FROM password_recovery WHERE idUser = ? AND token = ?");
    $stmt->execute(array($user_id, $token));
    return $stmt->fetch();
  }

  function resetPassword($user_id, $new_password, $token) {
    global $conn;
    $stmt = $conn->prepare("SELECT reset_password(?, ?, ?)");
    $stmt->execute(array($user_id, sha1($new_password), $token));
  }

  function changeAdminStatus($user_id, $setAdmin){
    global $conn;
    $stmt = $conn->prepare("UPDATE Users SET isAdmin = ? WHERE idUser = ? AND isAdmin <> ?");
    $stmt->execute(array($setAdmin, $user_id, $setAdmin));
    return $stmt->fetch() !== false;
  }

  function getUserInfoFromNameOrEmail($user){
    global $conn;
    $stmt = $conn->prepare("SELECT idUser AS id, username, email, nif, isadmin, COUNT(idUser) OVER () AS total_count FROM Users
            WHERE LOWER(username) = LOWER(?) OR LOWER(email) = LOWER(?);");
    $stmt->execute(array($user, $user));
    return $stmt->fetchAll();
  }

  function getAllUsers($limit, $page, $adminOnly = false)
  {
    $offset = ($page - 1) * $limit;
    global $conn;
    $stmt = $conn->prepare(
        "SELECT iduser AS id, username, email, nif, isadmin AS admin, COUNT(idUser) OVER () AS total_count FROM Users " .
        ($adminOnly ? "WHERE isAdmin = 'true'" : "")
        . " LIMIT ? OFFSET ?;"
    );
    $stmt->execute(array($limit, $offset));
    return $stmt->fetchAll();
  }

  function addAddress($idUser, $name, $address1, $address2, $phoneNumber, $zip1, $zip2)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT insert_address(?, ?, ?, ?, ?, ?, ?);");
    $stmt->execute(array($idUser, $name, $address1, $address2, $phoneNumber, $zip1, $zip2));
    return $stmt->fetch()['insert_address'];
  }

  function deleteAddress($idAddress)
  {
    global $conn;
    $stmt = $conn->prepare("DELETE FROM Address WHERE idAddress = ?;");
    $stmt->execute(array($idAddress));
  }

  function editAddress($idAddress, $name, $address1, $address2, $phoneNumber, $zip1, $zip2){
    global $conn;
    $stmt = $conn->prepare("UPDATE Address SET name = ?, address1 = ?, address2 = ?, phoneNumber = ?, idZipCode = ZipCode.idZipCode
      FROM ZipCode
      WHERE idAddress = ? AND code1 = ? and code2 = ?;");
    $stmt->execute(array($name, $address1, $address2, $phoneNumber, $idAddress, $zip1, $zip2));
    return $stmt->fetch();
  }

?>
