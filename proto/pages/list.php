<?php
	include_once('../config/init.php');
	include_once($BASE_DIR .'database/products.php');
	include_once($BASE_DIR .'lib/pagination.php');

	$cat = $_GET['cat'];
	$category = (isset($cat) && $cat != "" && is_numeric($cat)) ? $cat : null;
	$query = (isset($_GET['search']) && $_GET['search'] != "") ? $_GET['search'] : null;
	$page = isset($_GET['page']) ? $_GET['page'] : 1;
	$limit = isset($_GET['limit']) ? $_GET['limit'] : 8;

	if(!$query)
		$products = getCategoryProducts($category, $limit, $page, $_GET['order']);
	else
		$products = searchProducts($query, $limit, $page, $_GET['order'], $category);

	$order_value = (processProductOrderBy($_GET['order']) == "" ? null : $_GET['order']);
	
	extract(pagination($products, $limit, $page));

	if($category) {
		$smarty->assign('categories', getSubCategories($category));
		$breadcrumbs = getCategoryBreadcrumbs($category);
		$smarty->assign('breadcrumbs', $breadcrumbs);
		$smarty->assign('category', $category);
	} else 
		$smarty->assign('categories', getMainCategories());

	$smarty->assign('query', $query);
	$smarty->assign('page', $page);
	$smarty->assign('order', $order_value);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('products', $products);
	$smarty->display('products/list.tpl');
?>