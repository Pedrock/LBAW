<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/user_check.php');
include_once($BASE_DIR .'database/users.php');

$addresses = getUserAddresses($_SESSION['user']);
$nif = $addresses[0]['nif'];
if ($addresses[0]['id'] == null) $addresses = array();

$smarty->assign('addresses',$addresses);
$smarty->assign('nif',$nif);
$smarty->display('checkout/checkout.tpl');
