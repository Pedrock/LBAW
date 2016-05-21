<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/cart.php');

if (empty($_SESSION['user']))
    $cart = array();
else
    $cart = getUserCart($_SESSION['user']);

$smarty->assign('cart', $cart);
$smarty->display('products/cart.tpl');
?>