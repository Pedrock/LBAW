<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_GET['id'])
		return_error('No category provided');

	$category_id = trim($_GET['id']);

	try {
		$parent_categories = getCategoryBreadcrumbs($category_id);
		$unsorted_sub_categories = getCategoryChildren($category_id);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the category. Please try again." . $e->getMessage());
	}

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

	addChilds($unsorted_sub_categories, $arr, $parent_categories[1]['id'], count($parent_categories)-1);

	$smarty->assign('category_id', $category_id);
	$smarty->assign('level', count($parent_categories));
	$smarty->assign('categories', $arr);
	$output = $smarty->fetch('admin/categories/category.tpl');
	echo $output;
	function return_error($error) {
		http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>