<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'lib/admin_check.php');
	include_once($BASE_DIR . 'database/products.php');
	include_once($BASE_DIR .'database/users.php');
	include_once($BASE_DIR .'lib/pagination.php');

	/*if (isset($_GET['show_shipped'])) {
		$checked = $_GET['show_shipped'];
		$user_id = $_SESSION['user'];
		$page = isset($_GET['page']) ? $_GET['page'] : 1;
		$limit = isset($_GET['limit']) ? $_GET['limit'] : 10;

		$orders = show_shipments($checked, $limit, $page);

		extract(pagination($orders, $limit, $page));

		$smarty->assign('orders', $orders);
		$smarty->assign('page', $page);
		$smarty->assign('n_pages', $n_pages);
		$smarty->assign('startpage', $startpage);
		$smarty->assign('endpage', $endpage);
		$smarty->assign('limit', $limit);
		$smarty->display('admin/orders_management.tpl');
	}
	else{
		http_response_code(400);
	}*/
		$page = isset($_GET['page']) ? $_GET['page'] : 1;
  		$limit = isset($_GET['limit']) ? $_GET['limit'] : 10;
		$orders = show_shipments(false, $limit, $page); //TODO

		extract(pagination($orders, $limit, $page));

		$smarty->assign('orders', $orders);
		$smarty->assign('page', $page);
		$smarty->assign('n_pages', $n_pages);
		$smarty->assign('startpage', $startpage);
		$smarty->assign('endpage', $endpage);
		$smarty->assign('limit', $limit);
		$smarty->display('admin/orders_management.tpl');
	
?>