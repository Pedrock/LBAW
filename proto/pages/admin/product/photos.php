<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (isset($_GET['id'])) {
		$id = $_GET['id'];
		$product = getProduct($id, true);
		if ($product === false) {
			http_response_code(404);
			$smarty->display('404.tpl');
		} else {
			$smarty->assign('product', $product);
			$smarty->assign('id', $id);
			$smarty->assign('photos', getProductPhotos($id));
			$smarty->display('admin/product/photos.tpl');
		}
	} else {
		http_response_code(404);
		$smarty->display('404.tpl');
	}	
?>
