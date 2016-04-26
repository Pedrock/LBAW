<?php
  include_once('../config/init.php');
  include_once($BASE_DIR .'database/products.php');

  $page = isset($_GET['page']) ? $_GET['page'] : 1;
  $limit = 8;

  $n_pages = 10;

  $startpage = max(1,$page-2);
  $endpage = min($n_pages,$page+2);

  $dif = $endpage - $startpage;

  if ($dif < 4)
  {
  	if ($startpage > 1)
  		$startpage -= min($startpage-1,4-$dif);
  	else if ($endpage < $n_pages)
  		$endpage += min($n_pages-$endpage,4-$dif);
  }

  $smarty->assign('categories', getMainCategories());
  $smarty->assign('products', getFeaturedProducts($limit,$page));
  $smarty->assign('page', $page);
  $smarty->assign('n_pages', $n_pages);
  $smarty->assign('startpage', $startpage);
  $smarty->assign('endpage', $endpage);
  $smarty->assign('limit', $limit);
  $smarty->display('main/index.tpl');
?>