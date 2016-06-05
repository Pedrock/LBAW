<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');
	include_once($BASE_DIR .'lib/pagination.php');  

	include_once($BASE_DIR . 'lib/admin_check.php');

  	$page = isset($_GET['page']) ? $_GET['page'] : 1;
  	$limit = isset($_GET['limit']) ? $_GET['limit'] : 16;
  	$active = isset($_GET['active']);

	
	$coupons =  getCoupons($limit, $page, $active);

	extract(pagination($discounts,$limit,$page));

	if($query && isset($_GET['create']))
		$smarty->assign('create', true);
	$smarty->assign('coupons', $coupons);
	$smarty->assign('page', $page);
	$smarty->assign('active', $active);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	
	$smarty->display('admin/coupons.tpl');
?>