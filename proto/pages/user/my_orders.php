<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'lib/user_check.php'); 
  include_once($BASE_DIR .'database/products.php');
  include_once($BASE_DIR .'database/users.php');
  include_once($BASE_DIR .'lib/pagination.php'); 

  $user_id = $_SESSION['user'];
  $page = isset($_GET['page']) ? $_GET['page'] : 1;
  $limit = isset($_GET['limit']) ? $_GET['limit'] : 10;
  $orders = getPurchaseHistory($user_id,$limit,$page);

  extract(pagination($orders,$limit,$page));

  $smarty->assign('categories', getMainCategories());
  $smarty->assign('orders', $orders);
  $smarty->assign('productsOrder', $productsOrder);
  $smarty->assign('page', $page);
  $smarty->assign('n_pages', $n_pages);
  $smarty->assign('startpage', $startpage);
  $smarty->assign('endpage', $endpage);
  $smarty->assign('limit', $limit);

  $smarty->display('user/my_orders.tpl');
?>