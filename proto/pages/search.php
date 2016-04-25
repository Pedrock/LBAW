<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/products.php');  
include_once($BASE_DIR .'lib/pagination.php');  
if (isset($_GET['q']))
{
	$query = $_GET['q'];
	$page = isset($_GET['page']) ? $_GET['page'] : 1;
	$limit = isset($_GET['limit']) ? $_GET['limit'] : 8;
	$products = searchProducts($query,$limit,$page);

	extract(pagination($products,$limit,$page));

	$smarty->assign('categories', getMainCategories());
	$smarty->assign('query', $query);
	$smarty->assign('page', $page);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('products', $products);
	$smarty->display('products/search.tpl');
}
else
{
	http_response_code(400);
}
?>