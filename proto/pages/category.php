<?php
  include_once('../config/init.php');
  include_once($BASE_DIR .'database/products.php');
  include_once($BASE_DIR .'lib/pagination.php');  
  if (!isset($_GET['id']))
  {
  	http_response_code(400);
  	die();
  }
  $category = $_GET['id'];
  $smarty->assign('categories', getSubCategories($category));

  $page = isset($_GET['page']) ? $_GET['page'] : 1;
  $limit = isset($_GET['limit']) ? $_GET['limit'] : 8;
  $products = getCategoryProducts($category,$limit,$page);
  $breadcrumbs = getCategoryBreadcrumbs($category);

  extract(pagination($products,$limit,$page));

  $smarty->assign('category', $category);
  $smarty->assign('breadcrumbs', $breadcrumbs);
  $smarty->assign('page', $page);
  $smarty->assign('n_pages', $n_pages);
  $smarty->assign('startpage', $startpage);
  $smarty->assign('endpage', $endpage);
  $smarty->assign('limit', $limit);
  $smarty->assign('products', $products);
  $smarty->display('products/category.tpl');
?>