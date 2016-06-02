<?php
  
  function getProduct($id,$get_if_deleted) {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT idProduct AS id,name,description,round(cast(averagescore AS numeric),1) AS averagescore,stock,price,discount,new_price, weight, isdeleted
        FROM Product,get_product_discount_and_price(idProduct)
        WHERE idProduct = ?".($get_if_deleted ? "" : " AND isDeleted = FALSE" ).";");
    $stmt->execute(array($id));
    return $stmt->fetch();
  }

  function getProductScore($id){
    global $conn;
    $stmt = $conn->prepare("SELECT round(cast(averagescore AS numeric),1) AS averagescore FROM Product WHERE idProduct = ?");
    $stmt->execute(array($id));
    return $stmt->fetch()['averagescore'];
  }

  function getProductAndUserReview($id, $user_id) {
    global $conn;
    $stmt = $conn->prepare(
      "SELECT Product.idProduct AS id,name,description,round(cast(averagescore AS numeric),1) AS averagescore,stock,price,discount,new_price,weight, 
      			Review.idUser IS NOT NULL AS reviewed, Favorite.idUser IS NOT NULL AS is_favorite
        FROM Product
        CROSS JOIN get_product_discount_and_price(idProduct)
        LEFT JOIN Review ON Review.idProduct = Product.idProduct AND idUser = ?
        LEFT JOIN Favorite ON Favorite.idProduct = Product.idProduct AND Favorite.idUser = ?
        WHERE Product.idProduct = ? AND isDeleted = FALSE;");
    $stmt->execute(array($user_id,$user_id,$id));
    return $stmt->fetch();
  }

  function getCarousel()
  {
    global $conn;
    $stmt = $conn->prepare('SELECT location as image, link FROM CarouselPhoto WHERE active = TRUE ORDER BY photo_order');
    $stmt->execute();
    return $stmt->fetchAll();
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
      "SELECT body,score,username AS reviewer,to_char(review_date,'YYYY-MM-DD HH24:MI') AS review_date FROM Review 
        INNER JOIN Users USING(idUser)
        WHERE Review.idProduct = ? AND body IS NOT NULL
        ORDER BY review_date DESC
        LIMIT ? OFFSET ?;");
    $stmt->execute(array($idProduct,$limit,$offset));
    return $stmt->fetchAll();
  }

  function createProductReview($idProduct, $idUser, $score, $body)
  {
  	global $conn;
  	$stmt = $conn->prepare(
  		"INSERT INTO REVIEW(idProduct,idUser,score,body) VALUES(?, ?, ?, ?) RETURNING to_char(review_date,'YYYY-MM-DD HH24:MI') AS review_date;");
  	$stmt->execute(array($idProduct, $idUser, $score, $body));
  	return $stmt->fetch()['review_date'];
  }

  function getFeaturedProducts($limit, $page)
  {
    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
      "SELECT f.idProduct AS id, name, discount, get_product_price(f.idProduct) price, photo
        FROM
        (SELECT P.idProduct, name, COALESCE(percentage,0) AS discount, location AS photo
        FROM Product P
        LEFT JOIN Discount USING(idProduct)
        LEFT JOIN Photo ON Photo.idProduct = P.idProduct AND photo_order = 1
        WHERE isDeleted = FALSE 
        ORDER BY discount DESC, purchases DESC
        LIMIT ? OFFSET ?) AS f;");
    $stmt->execute(array($limit,$offset));
    return $stmt->fetchAll();
  }

  function searchProducts($query, $limit, $page, $order_by = "", $category = null)
  {
    $order_by = processProductOrderBy($order_by);
    $offset = ($page-1)*$limit;
    global $conn;
    if ($order_by == "") $order_by = "ts_rank_cd(tsv, q) DESC";
    $category_filter = $category == null ? "" : "AND idproduct in (SELECT get_category_products(?))";
    $stmt = $conn->prepare(
    	"SELECT results.idProduct AS id, name, price, total_count, location AS photo
    	FROM
    	(SELECT idProduct, name, get_product_price(P.idProduct) price, COUNT(idProduct) OVER () AS total_count
    	FROM product_search
    	INNER JOIN Product P USING(idProduct)
    	CROSS JOIN plainto_tsquery(?) AS q
    	WHERE (tsv @@ q) AND isDeleted = FALSE $category_filter
    	ORDER BY $order_by
    	LIMIT ? OFFSET ?) results
    	LEFT JOIN Photo ON results.idProduct = Photo.idProduct and photo_order = 1;");

    if($category == null)
      $arr = array($query,$limit,$offset);
    else
      $arr = array($query,$category,$limit,$offset);

    $stmt->execute($arr);
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

  function getAllProductCategories($id)
  {
    global $conn;
    $stmt = $conn->prepare('SELECT idCategory FROM CategoryProduct WHERE idProduct = ?');
    $stmt->execute(array($id));
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

  function processProductOrderBy($order)
  {
    switch($order)
    {
      case "pa": return "price ASC";
      case "pd": return "price DESC";
      case "na": return "name ASC";
      case "nd": return "name DESC";
      default: return "";
    }
  }

  function getCategoryProducts($category, $limit, $page, $order_by = "")
  {
    $order_by = processProductOrderBy($order_by);
    if ($order_by != "") $order_by = "ORDER BY ".$order_by;
    $offset = ($page-1)*$limit;
    global $conn;
    if ($category === null)
    {
      $stmt = $conn->prepare(
        "SELECT P.idproduct AS id,name,get_product_price(P.idProduct) price, COUNT(P.idProduct) OVER () AS total_count, location AS photo
          FROM Product P
          LEFT JOIN Photo ON P.idProduct = Photo.idProduct and photo_order = 1
          ".$order_by."
          LIMIT ? OFFSET ?;");
      $stmt->execute(array($limit, $offset));
    }
    else
    {
      $stmt = $conn->prepare(
        "SELECT P.idproduct AS id,name,get_product_price(P.idProduct) price, COUNT(P.idProduct) OVER () AS total_count, location AS photo
          FROM get_category_products(?) AS idProduct
          INNER JOIN Product P USING(idProduct)
          LEFT JOIN Photo ON P.idProduct = Photo.idProduct and photo_order = 1
          ".$order_by."
          LIMIT ? OFFSET ?;");
      $stmt->execute(array($category, $limit, $offset));
   }
    return $stmt->fetchAll();
  }

  function getOrders($limit, $page, $pending_only = false){

    $offset = ($page-1)*$limit;
    global $conn;
    $stmt = $conn->prepare(
        "SELECT idOrder AS id, totalPrice AS price, to_char(orderDate,'YYYY-MM-DD HH24:MI') AS orderdate, order_status, shipping_name, shipping_phone, shipping_address1, shipping_address2, shipping_city, shipping_zip1, shipping_zip2, billing_name, billing_phone, billing_address1, billing_address2, billing_city, billing_zip1, billing_zip2, COUNT(idOrder) OVER () AS total_count 
          FROM Orders ".
        ($pending_only ? "WHERE order_status != 'Sent'" : "")
        ." ORDER BY orderDate
          LIMIT ? OFFSET ?;"
    );
    $stmt->execute(array($limit, $offset));
    return $stmt->fetchAll();
  }

  function searchOrder($id)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT idOrder AS id, totalPrice AS price, to_char(orderDate,'YYYY-MM-DD HH24:MI') AS orderdate, order_status, shipping_name, shipping_phone, shipping_address1, shipping_address2, shipping_city, shipping_zip1, shipping_zip2, billing_name, billing_phone, billing_address1, billing_address2, billing_city, billing_zip1, billing_zip2, COUNT(idOrder) OVER () AS total_count 
          FROM Orders
          WHERE idOrder = ?");
    $stmt->execute(array($id));
    return $stmt->fetchAll();
  }

  function getInfoShipments($order_id)
  {
    global $conn;

    $stmt1 = $conn->prepare(
      "SELECT order_status AS status, totalprice, shipping_name, shipping_phone, shipping_address1, shipping_address2, shipping_city, shipping_zip1, shipping_zip2, billing_name, billing_phone, billing_address1, billing_address2, billing_city, billing_zip1, billing_zip2, 
        Coupon.percentage AS coupon_discount, shippingcost
            FROM Orders 
            LEFT JOIN Coupon USING(idcoupon)
            WHERE idOrder = ?");
    
    $stmt2 = $conn->prepare(
      "SELECT ProductOrder.idProduct AS id, product_status, location AS photo, ProductOrder.quantity, name, ProductOrder.price
                FROM ProductOrder
                INNER JOIN Product USING(idProduct)
                LEFT JOIN Photo ON ProductOrder.idProduct = Photo.idProduct AND photo_order = 1
          WHERE idOrder = ?");
    
    $conn->beginTransaction();
    $stmt1->execute(array($order_id));
    $stmt2->execute(array($order_id));
    $conn->commit();

    $order_info = $stmt1->fetch();
    $order_products = $stmt2->fetchAll();
    return array($order_info, $order_products);
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

  function getCategoryChildren($category)
  {
    global $conn;
    $stmt = $conn->prepare(
      "WITH RECURSIVE children( idcategory ) 
        AS (
          SELECT idcategory, idsupercategory, name
          FROM category
          WHERE idcategory = ?

          UNION ALL

          SELECT t.idcategory, t.idsupercategory, t.name
          FROM children c
          JOIN category t
          ON c.idcategory = t.idsupercategory
        )
        SELECT idCategory AS id, idsupercategory AS parent, name FROM children");
    $stmt->execute(array($category));
    return $stmt->fetchAll();
  }

  
  function createProduct($name, $price, $stock, $weight, $description, $categories, $hidden = false) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO Product(name, price, stock, weight, description, isDeleted) VALUES (?, ?, ?, ?, ?, ?) RETURNING idProduct");
    $stmt->execute(array($name, $price, $stock, $weight, $description, $hidden));
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

  function editProduct($id, $name, $price, $stock, $weight, $description, $categories, $deleted = false) {
    global $conn;
    $stmt = $conn->prepare("UPDATE Product SET name = ?, price = ?, stock = stock + ?, weight = ?, description = ?, isdeleted = ? WHERE idProduct = ?");
    $stmt->execute(array($name, $price, $stock, $weight, $description, $deleted, $id));

    if($categories != null) {
      $stmt = $conn->prepare("DELETE FROM CategoryProduct WHERE idProduct = ?");
      $stmt->execute(array($id));

      $query = "INSERT INTO CategoryProduct (idProduct, idCategory) VALUES ";
      $first = true;
      $arr = array();
      foreach($categories as $cat) {
        if(!$first)
          $query = $query . ',';
        else
          $first = false;

        $query = $query . '(?,?)';
        array_push($arr, $id);
        array_push($arr, $cat);
      }

      $stmt = $conn->prepare($query);
      $stmt->execute($arr);
    }
  }

  function addProductPhoto($product_id, $order, $file) {
    global $conn;
    $stmt = $conn->prepare("SELECT add_photo(?, ?, ?)");
    $stmt->execute(array($product_id, $order, $file));
  }

  function editProductPhoto($product_id, $order, $new_order) {
    global $conn;
    $stmt = $conn->prepare("SELECT update_photo_order(?, ?, ?)");
    $stmt->execute(array($product_id, $order, $new_order));
  }

  function deleteProductPhoto($product_id, $order) {
    global $conn;
    $stmt = $conn->prepare("SELECT delete_photo(?, ?)");
    $stmt->execute(array($product_id, $order));
    return $stmt->fetch()['delete_photo'];
  }

  function createCategory($name, $parent) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO category(name, idSupercategory) VALUES (?, ?) RETURNING idCategory");
    $stmt->execute(array($name, $parent));
    return $stmt->fetch()['idcategory'];
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
  function deleteProduct($id, $bool) {
    global $conn;
    $stmt = $conn->prepare("UPDATE product SET isDeleted = ? WHERE idProduct = ?");
    $stmt->execute(array($bool, $id));
  }

  function shipOrder($order_id)
  {
    global $conn;
    $stmt = $conn->prepare("UPDATE ProductOrder
	SET product_status = 'Sent'
	WHERE idOrder = ?;");
    $stmt->execute(array($order_id));
  }

  function updateProductOrder($order_id, $product_id, $status)
  {
    global $conn;
    $stmt = $conn->prepare("UPDATE ProductOrder
	SET product_status = ?
	WHERE idOrder = ? AND idProduct = ?;");
    $stmt->execute(array($status, $order_id, $product_id));
  }

  function getOrderStatus($order_id)
  {
    global $conn;
    $stmt = $conn->prepare("SELECT order_status
      FROM Orders 
      WHERE idOrder = ?");
    $stmt->execute(array($order_id));
    return $stmt->fetch();
  }
?>