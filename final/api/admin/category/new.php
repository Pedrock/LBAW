<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['name'])
		return_error('A category needs a name');

	$name = trim($_POST['name']);

	if(isset($_POST['parent'])) {
		$parent = $_POST['parent'];
		if(!is_numeric($parent) || $parent <= 0)
			return_error('Invalid parent category');
	} else
		$parent = null;

	try {
		$category_id = createCategory($name, $parent);
		$parent_categories = getCategoryBreadcrumbs($category_id);
		$unsorted_sub_categories = getCategoryChildren($category_id);
		
	} catch (PDOException $e) {
		return_error("An error occurred while creating the category. Please try again." . $e->getMessage());
	}

	$arr = array();
	addChilds($unsorted_sub_categories, $arr, $parent_categories[1]['id'], count($parent_categories)-1);

	$smarty->assign('category_id', $category_id);
	$smarty->assign('level', count($parent_categories));
	$smarty->assign('categories', $arr);
	$output = $smarty->fetch('admin/categories/category.tpl');

	echo json_encode(array("id" => $category_id, "html" => $output));

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

	function return_error($error) {
		http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>