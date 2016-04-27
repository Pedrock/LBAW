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

  function getProductPhotos($idProduct) {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT location, photo_order
      FROM Photo
      WHERE idProduct = ?
      ORDER BY photo_order");
    $stmt->execute(array($idProduct));
    return $stmt->fetchAll();
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

  function getFeaturedProducts($limit, $page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
      "SELECT f.idProduct AS id, name, discount, get_product_price(f.idProduct) price, location AS photo
        FROM
        (SELECT P.idProduct, name, COALESCE(percentage,0) AS discount
        FROM Product P
        LEFT JOIN Discount USING(idProduct)
        ORDER BY discount DESC, purchases DESC
        LIMIT ? OFFSET ?) f
        LEFT JOIN Photo ON Photo.idProduct = f.idProduct AND photo_order = 1;");
    $stmt->execute(array($limit,$offset));
    return $stmt->fetchAll();
  }

  function searchProducts($query, $limit, $page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
       "SELECT P.idProduct AS id, name, get_product_price(P.idProduct) price, product_count, location AS photo
        FROM
          (SELECT idProduct, COUNT(idProduct) OVER () AS product_count
          FROM product_search, plainto_tsquery(?) AS q
          WHERE (tsv @@ q)
          ORDER BY ts_rank_cd(tsv, q) DESC 
          LIMIT ? OFFSET ?) results
        INNER JOIN Product P USING(idProduct)
        LEFT JOIN Photo ON P.idProduct = Photo.idProduct and photo_order = 1;");
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

  function getAllCategories()
  {
    global $conn;
    $stmt = $conn->prepare('SELECT idCategory AS id, name, idSuperCategory as parent FROM Category ORDER BY name');
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
      "SELECT P.idproduct AS id,name,get_product_price(P.idProduct) price, COUNT(P.idProduct) OVER () AS product_count, location AS photo
        FROM get_category_products(?) AS idProduct
        INNER JOIN Product P USING(idProduct)
        LEFT JOIN Photo ON P.idProduct = Photo.idProduct and photo_order = 1
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

    if($categories != null) {
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
    }

    return $product_id;
  }

  function createEmptyProduct() {
        global $conn;
    $stmt = $conn->prepare("INSERT INTO Product(name, price, stock, weight, description) VALUES (?, ?, ?, ?, ?) RETURNING idProduct");
    $stmt->execute(array($name, $price, $stock, $weight, $description));
    $product_id = $stmt->fetch()['idproduct'];

    if($categories != null) {
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
    }

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

  function createCategory($name, $parent) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO category(name, idSupercategory) VALUES (?, ?) RETURNING idCategory");
    $stmt->execute(array($name, $parent));
    return $$stmt->fetch()['idCategory'];
  }

  function editCategory($id, $name, $parent) {
    global $conn;
    $stmt = $conn->prepare("UPDATE category SET name = ?, idSupercategory = ? WHERE idCategory = ?");
    $stmt->execute(array($name, $parent, $id));
  }

  function deleteCategory($id) {
    global $conn;
    $stmt = $conn->prepare("DELETE from category WHERE idCategory = ?");
    $stmt->execute(array($id));
  }
?>