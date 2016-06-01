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
?>
