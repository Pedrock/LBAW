<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/products.php');  
if (isset($_GET['id']))
{
	$id = $_GET['id'];
	$product = getProduct($id);
	if ($product === false)
	{
		http_response_code(404);
	}
	else
	{
		$smarty->assign('product', $product);
		$smarty->assign('reviews', getProductReviews($id,10,1));
		$smarty->assign('photos', getProductPhotos($id));
		$smarty->display('products/product-page.tpl');
	}
}
else
{
	http_response_code(400);
}
?>