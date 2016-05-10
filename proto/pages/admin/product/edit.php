<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (isset($_GET['id']))
	{
		$id = $_GET['id'];
		$product = getProduct($id,true);
		if ($product === false)
		{
			http_response_code(404);
		}
		else
		{
			$unsorted = getAllCategories();
			$ofProduct = getAllProductCategories($id);
			$productcategories = array();
			foreach ($ofProduct as $category) {
				array_push($productcategories, $category['idcategory']);
			}
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
			$smarty->assign('product', $product);
			$smarty->assign('id', $id);
			$smarty->assign('productcategories', $productcategories);
			$smarty->display('admin/product/edit.tpl');
			
		}
	}
	else
	{
		http_response_code(404);
	}	
?>
