<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/cart_cookie.php');
include_once($BASE_DIR .'database/cart.php');

function validPostNumber($var)
{
    return (!empty($var) && is_numeric($var));
}

if (!validPostNumber($_POST['product']) || !validPostNumber($_POST['quantity']))
{
    http_response_code(400);
    die();
}

if (empty($_SESSION["user"]))
{
    if (!empty($_COOKIE['cart']))
    {
        $products = explode(';',$_COOKIE['cart']);
        $length = count($products);
        for ($i = 0; $i < $length; $i++)
        {
            list($product_id,$product_quantity) = explode(':',$products[$i],2);
            if ($product_id == $_POST['product'])
            {
                $products[$i] = $_POST['product'].':'.$_POST['quantity'];
                break;
            }
        }
        $cookie = implode(";",$products);
        try {
            $shipping = getShippingFromJson(get_cart_json($cookie));
        }
        catch (Exception $e) {$shipping = 'Too heavy';}
    }
}
else
{
    updateCartProductQuantity($_POST['product'], $_SESSION["user"], $_POST['quantity']);
    try {
        $shipping = getUserCartShipping($_SESSION['user']);
    }
    catch (Exception $e) {$shipping = 'Too heavy';}
}

try {
    echo json_encode(array('enough_stock' => enoughStock($_POST['product'], $_POST['quantity']), 'shipping' => $shipping));
    if (isset($cookie))
        setcookie('cart', $cookie, 2147483647, $BASE_URL);
}
catch (Exception $e) {
    http_response_code(400);
}

?>