<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	$smarty->assign('purchases', getPurchases());
	$smarty->display('admin/index.tpl');
?>