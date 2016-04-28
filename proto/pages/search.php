<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/products.php');  
include_once($BASE_DIR .'lib/pagination.php');  
if (isset($_GET['q']))
{
	$query = $_GET['q'];
	$page = isset($_GET['page']) ? $_GET['page'] : 1;
	$limit = isset($_GET['limit']) ? $_GET['limit'] : 8;
	$products = searchProducts($query,$limit,$page,$_GET['order']);

	extract(pagination($products,$limit,$page));

	$order_value = (processProductOrderBy($_GET['order']) == "" ? null : $_GET['order']);

	$smarty->assign('categories', getMainCategories());
	$smarty->assign('query', $query);
	$smarty->assign('page', $page);
	$smarty->assign('order', $order_value);
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