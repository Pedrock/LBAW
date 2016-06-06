<?php
function addProductToCart($id, $user_id, $quantity)
{
    global $conn;
    $stmt = $conn->prepare("SELECT add_to_cart(?, ?, ?)");
    $stmt->execute(array($user_id, $id, $quantity));
}

function updateCartProductQuantity($id, $user_id, $quantity)
{
    global $conn;
    $stmt = $conn->prepare("UPDATE ProductCart SET quantity = ? WHERE idUser = ? AND idProduct = ?");
    $stmt->execute(array($quantity, $user_id, $id));
}

function enoughStock($product_id, $quantity)
{
    global $conn;
    $stmt = $conn->prepare("SELECT stock >= ? AS enough_stock FROM Product WHERE idProduct = ?");
    $stmt->execute(array($quantity, $product_id));
    return $stmt->fetch()['enough_stock'];
}

function removeProductFromCart($id, $user_id)
{
    global $conn;
    $stmt = $conn->prepare("DELETE FROM ProductCart WHERE idUser = ? AND idProduct = ?");
    $stmt->execute(array($user_id, $id));
}

function getUserCart($user_id)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT Product.idProduct AS id, name, quantity, ProductCart.price AS cart_price, 
            get_product_price(Product.idProduct) AS price, 
            location AS photo, stock >= quantity AS enough_stock
        FROM ProductCart
        INNER JOIN Product USING(idProduct)
        LEFT JOIN Photo ON Photo.idProduct = Product.idProduct AND photo_order = 1
        WHERE ProductCart.idUser = ? AND Product.isDeleted = false
        ORDER BY product_position;");
    $stmt->execute(array($user_id));
    return $stmt->fetchAll();
}

function getUserCartShipping($user_id)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT get_shipping_costs(SUM(weight*quantity)::INTEGER) AS shipping
        FROM ProductCart
        INNER JOIN Product USING(idProduct)
        WHERE ProductCart.idUser = ? AND Product.isDeleted = false;");
    $stmt->execute(array($user_id));
    return $stmt->fetch()['shipping'];
}

function getUserCartSimple($user_id)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT Product.idProduct AS id, name, quantity, ProductCart.price
        FROM ProductCart
        INNER JOIN Product USING(idProduct)
        WHERE ProductCart.idUser = ? AND Product.isDeleted = false
        ORDER BY product_position;");
    $stmt->execute(array($user_id));
    return $stmt->fetchAll();
}

function getCartFromJson($products)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT p AS id, name, q AS quantity, get_product_price(p) AS price, location AS photo, stock >= q AS enough_stock
        FROM json_to_recordset(?) as x(p int, q int)
        INNER JOIN Product ON p = idProduct
        LEFT JOIN Photo ON Photo.idProduct = Product.idProduct AND photo_order = 1
        WHERE Product.isDeleted = false;");
    $stmt->execute(array($products));
    return $stmt->fetchAll();
}

function getShippingFromJson($products)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT get_shipping_costs(SUM(weight*q)::INTEGER) AS shipping
        FROM json_to_recordset(?) as x(p int, q int)
        INNER JOIN Product ON p = idProduct
        WHERE Product.isDeleted = false;");
    $stmt->execute(array($products));
    return $stmt->fetch()['shipping'];
}

function addToCartFromJson($user_id, $products)
{
    global $conn;
    $stmt = $conn->prepare("SELECT add_to_cart_from_json(?,?)");
    $stmt->execute(array($user_id, $products));
}

function makeOrder($user_id, $billing_address, $shipping_address, $order_nif, $coupon_code)
{
    global $conn;
    $stmt = $conn->prepare("SELECT make_order(?, ?, ?, ?, ?)");
    $conn->beginTransaction();
    $conn->exec('SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;');
    $stmt->execute(array($user_id, $billing_address, $shipping_address, $order_nif, $coupon_code));
    $conn->commit();
    return $stmt->fetch()['make_order'];
}

function clearCart($user_id)
{
    global $conn;
    $stmt = $conn->prepare("DELETE FROM ProductCart WHERE idUser = ?;");
    $stmt->execute(array($user_id));
}

function prepareOrderPayment($order_id)
{
    global $conn;
    $conn->beginTransaction();
    $stmt = $conn->prepare("UPDATE Orders SET order_status = 'Pending' WHERE idOrder = ? AND order_status = 'Payment Pending';");
    $stmt->execute(array($order_id));
    return $stmt->fetch();
}

function finishOrderPayment()
{
    global $conn;
    $conn->commit();
}

function cancelOrderPayment()
{
    global $conn;
    if ($conn->inTransaction())
        $conn->rollBack();
}

function getCartCosts($user_id, $coupon_code = NULL)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT COALESCE((100-COALESCE(coupon_discount,0))*productsCost/100.0,0) AS totalprice,
              shippingcost,
              coupon_discount
    FROM
      (SELECT SUM(ProductCart.price*ProductCart.quantity) AS productsCost,
              get_shipping_costs(SUM(weight*quantity)::INTEGER) AS shippingCost,
              MAX(Coupon.percentage) AS coupon_discount
       FROM ProductCart
         INNER JOIN Product USING(idProduct)
         LEFT JOIN Coupon ON code IS NOT NULL AND code = ? AND now() BETWEEN startdate AND enddate
       WHERE ProductCart.idUser = ? GROUP BY idCoupon) costs");
    $stmt->execute(array($coupon_code, $user_id));
    return $stmt->fetch();
}

function getCouponDiscount($coupon_code)
{
    global $conn;
    $stmt = $conn->prepare(
        "SELECT percentage AS discount
         FROM Coupon
         WHERE code = ? AND isDeleted = FALSE AND now() BETWEEN startdate AND enddate");
    $stmt->execute(array($coupon_code));
    return $stmt->fetch();
}

function getOrderCosts($order_id)
{
    global $conn;
    $stmt = $conn->prepare("SELECT totalprice, shippingcost, percentage AS coupon_discount 
          FROM Orders 
          LEFT JOIN Coupon USING(idcoupon)
          WHERE idOrder = ?");
    $stmt->execute(array($order_id));
    return $stmt->fetch();
}

function addPreviousOrder($user_id, $order_id){
    global $conn;
    $conn->beginTransaction();
    $stmt = $conn->prepare("SELECT idproduct, quantity FROM productorder WHERE idorder = ?");
    $stmt->execute(array($order_id));
    $items = $stmt->fetchAll();
    foreach ($items as &$item) {
        addProductToCart($item['idproduct'], $user_id, $item['quantity']);
    }
    $conn->commit();
    return true;
}

function updateCartPrices($user_id)
{
    global $conn;
    $stmt = $conn->prepare("UPDATE ProductCart SET price = get_product_price(idProduct) WHERE idUser = ?");
    $stmt->execute(array($user_id));
    return $stmt->fetch();
}

?>