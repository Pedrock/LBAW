<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/user_check.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/cart.php');

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
    $billing_address = getUserAddress($_SESSION['user'], $_POST['ship_addr']);
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

$smarty->assign('shipping_address',$shipping_address);
$smarty->assign('billing_address',$billing_address);
$smarty->assign('nif',nif);
$smarty->assign('cart',$cart);
$smarty->display('checkout/confirm.tpl');
