<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'lib/admin_check.php');
	include_once($BASE_DIR . 'database/products.php');
	include_once($BASE_DIR .'database/users.php');
	include_once($BASE_DIR .'lib/pagination.php');

	$page = isset($_GET['page']) ? $_GET['page'] : 1;
  	$limit = isset($_GET['limit']) ? $_GET['limit'] : 10;
	$search = (empty($_GET['search']) || !is_numeric($_GET['search'])) ? null : trim($_GET['search']);
	if ($search)
	{
		$orders = searchOrder($search);
	}
	else
		$orders = getOrders($limit, $page, isset($_GET['pending']));

	extract(pagination($orders, $limit, $page));

	$smarty->assign('pending',isset($_GET['pending']));
	$smarty->assign('orders', $orders);
	$smarty->assign('page', $page);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('search', $search);
	$smarty->display('admin/orders.tpl');
	
?>