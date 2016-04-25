<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	// TODO order categories, maybe calculate level here instead of sql
	$smarty->assign('categories', getAllCategoriesLeveled());

	$smarty->display('admin/new_product.tpl');
?>