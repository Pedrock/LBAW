<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');
	include_once($BASE_DIR . 'database/users.php');
	include_once($BASE_DIR . 'lib/admin_check.php');

	include_once($BASE_DIR .'lib/pagination.php');

	$page = isset($_GET['page']) ? $_GET['page'] : 1;
  	$limit = isset($_GET['limit']) ? $_GET['limit'] : 10;
	$search = (empty($_GET['search'])) ? null : trim($_GET['search']);
	if ($search)
	{
		$users = getUserInfoFromNameOrEmail($search);
		$num = 1;
	}
	else{
		$users = getAllUsers($limit, $page, isset($_GET['adminOnly']));
		$num = userCount(isset($_GET['adminOnly']));
	}
	extract(pagination($users, $limit, $page, $num));

	$smarty->assign('adminOnly',isset($_GET['adminOnly']));
	$smarty->assign('users', $users);
	$smarty->assign('page', $page);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('search', $search);

	$smarty->display('admin/user/user.tpl');
?>