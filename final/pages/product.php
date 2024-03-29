<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/products.php');  
if (isset($_GET['id']))
{
	$id = $_GET['id'];
	if (empty($_SESSION['user']))
		$product = getProduct($id, false);
	else
		$product = getProductAndUserReview($id, $_SESSION['user']);
	
	if ($product === false)
	{
		http_response_code(404);
		$smarty->display('404.tpl');
	}
	else
	{
		$metadata = getMetadata($id);
		$smarty->assign('metadata', $metadata);
		$smarty->assign('product', $product);
		$smarty->assign('reviews', getProductReviews($id,10,1));
		$smarty->assign('photos', getProductPhotos($id));
		$smarty->display('products/product-page.tpl');
	}
}
else
{
	http_response_code(404);
	$smarty->display('404.tpl');
}
?>