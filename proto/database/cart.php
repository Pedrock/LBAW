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
        "SELECT Product.idProduct AS id, name, quantity, ProductCart.price AS cart_price, get_product_price(Product.idProduct) AS price, location AS photo, stock >= quantity AS enough_stock
        FROM ProductCart
        INNER JOIN Product USING(idProduct)
        LEFT JOIN Photo ON Photo.idProduct = Product.idProduct AND photo_order = 1
        WHERE ProductCart.idUser = ? AND Product.isDeleted = false
        ORDER BY product_position;");
    $stmt->execute(array($user_id));
    return $stmt->fetchAll();
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
    $conn->rollBack();
}

function getCartCosts($user_id, $coupon_code = NULL)
{
    global $conn;
    $stmt = $conn->prepare("SELECT COALESCE((100-coupon_discount)*productsCost/100.0 + shippingCost,0) AS totalprice, shippingcost FROM
    (SELECT SUM(ProductCart.price*ProductCart.quantity) AS productsCost,
            get_shipping_costs(SUM(weight)::INTEGER) AS shippingCost,
            COALESCE(MAX(Coupon.percentage), 0) AS coupon_discount
       FROM ProductCart
       INNER JOIN Product USING(idProduct)
       LEFT JOIN Coupon ON code IS NOT NULL AND code = ? AND startdate <= now() AND enddate >= now()
     WHERE ProductCart.idUser = ?) costs");
    $stmt->execute(array($coupon_code, $user_id));
    return $stmt->fetch();
}

function getOrderCosts($order_id)
{
    global $conn;
    $stmt = $conn->prepare("SELECT totalprice, shippingcost FROM Orders WHERE idOrder = ?");
    $stmt->execute(array($order_id));
    return $stmt->fetch();
}