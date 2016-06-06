<?php
include_once('../config/init.php');
include_once($BASE_DIR .'lib/cart_cookie.php');
include_once($BASE_DIR .'database/cart.php');

if (empty($_SESSION['user']))
{
    if (empty($_COOKIE['cart']))
        $cart = array();
    else {
        $json = get_cart_json();
        $cart = getCartFromJson($json);
        try {
            $shipping = getShippingFromJson($json);
        }
        catch (Exception $e) {$shipping = 'Too heavy';}
    }
}
else {
    $cart = getUserCart($_SESSION['user']);
    try {
        $shipping = getUserCartShipping($_SESSION['user']);
    }
    catch (Exception $e) {$shipping = 'Too heavy';}
}

if (isset($_GET['coupon']))
    $coupon = empty($_GET['coupon']) ? NULL : htmlspecialchars(trim($_GET['coupon']));
else if (isset($_SESSION['coupon'])) $coupon = $_SESSION['coupon'];
else $coupon = NULL;

if (!empty($coupon))
{
    $discount = getCouponDiscount($coupon);
    if ($discount !== false)
        $discount = $discount['discount'];
}
else
    $discount = NULL;

$invalid_coupon = $coupon && !$discount;

if ($discount)
    $_SESSION['coupon'] = $coupon;
else
    unset($_SESSION['coupon']);

if (empty($shipping)) $shipping = 0;

$smarty->assign('cart', $cart);
$smarty->assign('coupon', $coupon);
$smarty->assign('discount', $discount);
$smarty->assign('shipping', $shipping);
$smarty->assign('invalid_coupon', $invalid_coupon);
$smarty->display('products/cart.tpl');
?>