<?php
include_once($BASE_DIR .'database/cart.php');
function cart_cookie_to_db($user_id)
{
    global $BASE_URL;
    if (!empty($_COOKIE['cart']))
    {
        $products = explode(';',$_COOKIE['cart']);
        $length = count($products);
        $products_objects = array();
        for ($i = 0; $i < $length; $i++)
        {
            list($product_id,$product_quantity) = explode(':',$products[$i],2);
            $item = new stdClass();
            $item->p = $product_id;
            $item->q = $product_quantity;
            array_push($products_objects, $item);
        }
        $json = json_encode($products_objects);
        addToCartFromJson($user_id, $json);
        setcookie('cart', '', 2147483647, $BASE_URL);
    }
}