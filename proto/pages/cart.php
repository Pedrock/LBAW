<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/cart.php');

if (empty($_SESSION['user']))
{
    // '[{"p":1,"q":2},{"p":4,"q":10}]'
    if (empty($_COOKIE['cart']))
        $cart = array();
    else{
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
        $cart = getCartFromJson($json);
    }
}
else
    $cart = getUserCart($_SESSION['user']);

$smarty->assign('cart', $cart);
$smarty->display('products/cart.tpl');
?>