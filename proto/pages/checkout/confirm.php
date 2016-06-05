<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/user_check.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/cart.php');

/*if (!validNIF($_POST['nif']))
{
    header('Location: checkout.php'); // TODO
    die();
}*/

if (!empty($_POST['ship_addr']))
    $shipping_address = getUserAddress($_SESSION['user'], $_POST['ship_addr']);
else {
    $shipping_address = array(
        'name' => $_POST['shipping_name'],
        'address1' => $_POST['shipping_addr1'],
        'address2' => $_POST['shipping_addr2'],
        'zipcode' => $_POST['shipping_zip'],
        'city' => $_POST['shipping_city'],
        'phonenumber' => $_POST['shipping_phone']
    );
}
if (!empty($_POST['same']))
    $billing_address = $shipping_address;
else if (!empty($_POST['bill_addr'])) {
    $billing_address = getUserAddress($_SESSION['user'], $_POST['bill_addr']);
}
else {
    $billing_address = array(
        'name' => $_POST['billing_name'],
        'address1' => $_POST['billing_addr1'],
        'address2' => $_POST['billing_addr2'],
        'zipcode' => $_POST['billing_zip'],
        'city' => $_POST['billing_city'],
        'phonenumber' => $_POST['billing_phone']
    );
}

$nif = $_POST['nif'];

$cart = getUserCart($_SESSION['user']);

if (empty($cart))
{
    header("Location: $BASE_URL"."pages/cart.php");
    die();
}
$costs = getCartCosts($_SESSION['user']); // TODO - Coupon

$smarty->assign('shipping_address',$shipping_address);
$smarty->assign('billing_address',$billing_address);
$smarty->assign('nif',$nif);
$smarty->assign('cart',$cart);
$smarty->assign('shipping',round($costs['shippingcost'],2));
$smarty->assign('total',round($costs['totalprice'],2));
$smarty->assign('vars',$_POST);
$smarty->display('checkout/confirm.tpl');
