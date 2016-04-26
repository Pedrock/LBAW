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

  function getProductReviews($idProduct,$limit,$page)
  {
    $offset = ($page-1)*$limit;
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

  function searchProducts($query, $limit, $page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
       "SELECT idProduct AS id, name, get_product_price(idProduct) price, product_count
        FROM
          (SELECT idProduct, COUNT(idProduct) OVER () AS product_count
          FROM product_search, plainto_tsquery(?) AS q
          WHERE (tsv @@ q)
          ORDER BY ts_rank_cd(tsv, q) DESC 
          LIMIT ? OFFSET ?) results
        INNER JOIN Product USING(idProduct);");
    $stmt->execute(array($query,$limit,$offset));
    return $stmt->fetchAll();
  }

  function getMainCategories()
  {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idCategory AS id, name 
        FROM Category
        WHERE idSuperCategory IS NULL;");
    $stmt->execute();
    return $stmt->fetchAll();
  }

  function getAllCategoriesLeveled()
  {
    global $conn;
    /*$stmt = $conn->prepare(
      "WITH RECURSIVE CategoryRec AS 
       (
           SELECT idCategory, idSuperCategory, name, 1 as level
           FROM category
           where idSuperCategory IS NULL
       
           UNION ALL
       
           SELECT c.idCategory, c.idSuperCategory, c.name, (cr.Level + 1) as level
           FROM Category c INNER JOIN
           CategoryRec AS cr ON c.idSuperCategory = cr.idCategory
       ),
       CategoryRec2 as
       (
           SELECT idCategory, idSuperCategory, name, level
           FROM CategoryRec
       
           UNION ALL
       
           SELECT cr.idCategory, c.idSuperCategory, cr.name, cr.level
           FROM CategoryRec2 AS cr INNER JOIN
           CategoryRec AS c ON cr.idSuperCategory = c.idCategory
           WHERE c.idSuperCategory IS NOT NULL
       )
       SELECT idCategory as id, idSuperCategory, name, level
       FROM CategoryRec2;
       ;");*/
    $stmt = $conn->prepare('SELECT idCategory AS id, name FROM Category');
    $stmt->execute();
    return $stmt->fetchAll();
  }

  function getSubCategories($parent_category)
  {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idCategory AS id, name 
        FROM Category
        WHERE idSuperCategory = ?;");
    $stmt->execute(array($parent_category));
    return $stmt->fetchAll();
  }

  function getCategoryProducts($category, $limit, $page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idproduct AS id,name,get_product_price(idProduct) price, COUNT(idProduct) OVER () AS product_count
        FROM get_category_products(?) AS idProduct
        INNER JOIN Product USING(idProduct)
        LIMIT ? OFFSET ?;");
    $stmt->execute(array($category, $limit, $offset));
    return $stmt->fetchAll();
  }

  function getCategoryBreadcrumbs($category)
  {
    global $conn;
    $stmt = $conn->prepare(
      "WITH RECURSIVE parents( idcategory ) 
        AS (
          SELECT idcategory, idsupercategory, name
          FROM category
          WHERE idcategory = ?

          UNION ALL

          SELECT t.idcategory, t.idsupercategory, t.name
          FROM parents p
          JOIN category t
          ON p.idsupercategory = t.idcategory
        )
        SELECT idCategory AS id, idsupercategory AS parent, name FROM parents");
    $stmt->execute(array($category));
    return $stmt->fetchAll();
  }
  
  function createProduct($name, $price, $stock, $weight, $description, $categories) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO Product(name, price, stock, weight, description) VALUES (?, ?, ?, ?, ?) RETURNING idProduct");
    $stmt->execute(array($name, $price, $stock, $weight, $description));
    $product_id = $stmt->fetch()['idproduct'];
    $query = "INSERT INTO CategoryProduct (idProduct, idCategory) VALUES ";
    $first = true;
    $arr = array();
    foreach($categories as $cat) {
      if(!$first)
        $query = $query . ',';
      else
        $first = false;

      $query = $query . '(?,?)';
      array_push($arr, $product_id);
      array_push($arr, $cat);
    }
    $stmt = $conn->prepare($query);
    $stmt->execute($arr);

    return $product_id;
  }

  function addProductPhotos($product_id, $files) {
    global $conn;
    $query = "INSERT INTO Photo(idProduct, photo_order, location) VALUES ";
    $first = true;
    $i = 1;
    $arr = array();
    foreach($files as $file) {
      if(!$first)
        $query = $query . ',';
      else
        $first = false;

      $query = $query . "(?,?,?)";
      array_push($arr, $product_id);
      array_push($arr, $i++);
      array_push($arr, $product_id . '_' . $file);
    }
    $stmt = $conn->prepare($query);
    $stmt->execute($arr);

    return $product_id;
  }
?>