<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	$unsorted = getAllCategories();

	function addChilds($unsorted, &$arr, $parent, $level) {
		foreach($unsorted as $cat) {
			if($cat['parent'] == $parent) {
				$cat['level'] = $level;
				array_push($arr, $cat);
				$prev_count = count($arr);
				addChilds($unsorted, $arr, $cat['id'], $level + 1);
				$arr[$prev_count - 1]['numChilds'] = count($arr) - $prev_count;
			}
		}
	}

	$arr = array();

	addChilds($unsorted, $arr, null, 0);

	$smarty->assign('categories', $arr);

	$smarty->display('admin/categories.tpl');
?>