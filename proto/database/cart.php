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