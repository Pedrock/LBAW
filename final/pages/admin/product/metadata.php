<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (isset($_GET['id'])) {
		$id = $_GET['id'];
		$product = getProduct($id, true);
		if ($product === false) {
			http_response_code(404);
		} else {
			$smarty->assign('product', $product);
			$smarty->assign('id', $id);
			$smarty->assign('metadata', getMetadata($id));
			$smarty->assign('categories', getMetadataCategories());
			$smarty->display('admin/product/metadata.tpl');
		}
	} else {
		http_response_code(404);
	}	
?>
