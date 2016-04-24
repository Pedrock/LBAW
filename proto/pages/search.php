<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/products.php');  
if (isset($_GET['q']))
{
	$query = $_GET['q'];
	$page = isset($_GET['page']) ? $_GET['page'] : 1;
	$limit = isset($_GET['limit']) ? $_GET['limit'] : 8;
	$results = searchProducts($query,$limit,$page);

	if ($results !== false)
	{
		$product_count = $results[0]['product_count'];
		$pages = ($product_count - $product_count % $limit) / $limit + ($product_count % $limit > 0);
	}
	else
		$pages = 0;

	$startpage = max(1,$page-2);
	$endpage = min($pages,$page+2);

	$dif = $endpage - $startpage;

	if ($dif < 4)
	{
		if ($startpage > 1)
			$startpage -= min($startpage-1,4-$dif);
		else if ($endpage < $pages)
			$endpage += min($pages-$endpage,4-$dif);
	}

	$smarty->assign('query', $query);
	$smarty->assign('page', $page);
	$smarty->assign('pages', $pages);
	$smarty->assign('startpage', $startpage);
	$smarty->assign('endpage', $endpage);
	$smarty->assign('limit', $limit);
	$smarty->assign('results', $results);
	$smarty->display('products/search.tpl');
}
else
{
	http_response_code(400);
}
?>