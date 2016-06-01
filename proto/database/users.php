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

  // purchase history

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
?>