<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/pagination.php');  
	include_once($BASE_DIR . 'lib/admin_check.php');

	// Categories
	$unsorted = getAllCategories();

	function addChilds($unsorted, &$arr, $parent, $level) {
		foreach($unsorted as $cat) {
			if($cat['parent'] == $parent) {
				$cat['level'] = $level;
				array_push($arr, $cat);
				addChilds($unsorted, $arr, $cat['id'], $level + 1);
			}
		}
	}

	$arr = array();

	addChilds($unsorted, $arr, null, 0);

	$smarty->assign('categories', $arr);

	$category = (isset($_GET['category']) && $_GET['category'] != "" && is_numeric($_GET['category'])) ? $_GET['category'] : null;
	if(isset($_GET['category'])) {
		foreach($unsorted as $cat) {
			if($cat['id'] == $_GET['category']) {
				$category_name = $cat['name'];
				break;
			}
		}
	}

	if(!isset($category_name))
		$category_name = 'Categories';

	$search = (isset($_GET['search']) && $_GET['search'] != "") ? $_GET['search'] : null;

	$page = isset($_GET['page']) ? $_GET['page'] : 1;
	$limit = isset($_GET['limit']) ? $_GET['limit'] : 16;

	if(!$search)
		$products = getCategoryProducts($category,$limit,$page,$_GET['order']);
	else
		$products = searchProducts($search, $limit, $page, $_GET['order'], $category);

	$order_value = (processProductOrderBy($_GET['order']) == "" ? null : $_GET['order']);
	
	extract(pagination($products,$limit,$page));

	$promotion = isset($_GET['promotion']);
	$smarty->assign('promotion', $promotion);

	$smarty->assign('category', $category);
	$smarty->assign('search', $search);
	$smarty->assign('category_name', $category_name);
	$smarty->assign('breadcrumbs', $breadcrumbs);
	$smarty->assign('page', $page);
	$smarty->assign('n_pages', $n_pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('order', $order_value);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('products', $products);

	$smarty->display('admin/product/list.tpl');
?>