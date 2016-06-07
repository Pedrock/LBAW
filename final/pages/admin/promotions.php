<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');
	include_once($BASE_DIR .'lib/pagination.php');  

	include_once($BASE_DIR . 'lib/admin_check.php');

  	$page = isset($_GET['page']) ? $_GET['page'] : 1;
  	$limit = isset($_GET['limit']) ? $_GET['limit'] : 16;
  	$active = isset($_GET['active']);

	if(isset($_GET['search'])) {
		$query = $_GET['search'];
		$smarty->assign('query', $query);
	} else {
		$query = null;
	}

	if(is_numeric($query))
		$discounts = getDiscounts($limit, $page, $query, $active);
	else if(isset($_GET['search']) && $_GET['search'] != '')
		$discounts = array();
	else
		$discounts =  getDiscounts($limit, $page, $query, $active);

	extract(pagination($discounts,$limit,$page));

	$smarty->assign('create', ($query && isset($_GET['create'])));
	$smarty->assign('discounts', $discounts);
	$smarty->assign('page', $page);
	$smarty->assign('active', $active);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	
	$smarty->display('admin/promotions.tpl');
?>