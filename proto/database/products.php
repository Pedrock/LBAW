<?php
  
  function getProduct($id) {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idProduct AS id,name,description,round(cast(averagescore AS numeric),1) AS averagescore,stock,price,discount,new_price 
        FROM Product,get_product_discount_and_price(idProduct)
        WHERE idProduct = ?;");
    $stmt->execute(array($id));
    return $stmt->fetch();
  }

  function getProductReviews($idProduct,$limit,$offset)
  {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT body,score,username AS reviewer,review_date FROM Review 
        INNER JOIN Users USING(idUser)
        WHERE Review.idProduct = ? AND body IS NOT NULL
        ORDER BY review_date DESC
        LIMIT ? OFFSET ?;");
    $stmt->execute(array($idProduct,$limit,$offset));
    return $stmt->fetchAll();
  }
?>
