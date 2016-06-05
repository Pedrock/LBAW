<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if(isset($_GET['id'])) {
		$id = $_GET['id'];
		$smarty->assign('id', $id);
	}

	$smarty->assign('categories', getMetadataCategories());
	$smarty->display('admin/product/metadata_categories.tpl');
?>
