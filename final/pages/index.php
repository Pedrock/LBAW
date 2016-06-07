<?php
  include_once('../config/init.php');
  include_once($BASE_DIR .'database/products.php');

  $page = 1;
  $limit = 8;

  $n_pages = 10;

  $startpage = 1;
  $endpage = 5;

  $smarty->assign('carousel', getCarousel());
  $smarty->assign('categories', getMainCategories());
  $smarty->assign('products', getFeaturedProducts($limit*$n_pages,$page));
  $smarty->assign('page', $page);
  $smarty->assign('n_pages', $n_pages);
  $smarty->assign('startpage', $startpage);
  $smarty->assign('endpage', $endpage);
  $smarty->assign('limit', $limit);
  $smarty->display('main/index.tpl');
?>