<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['id'])
		return_error('A category id must be specified');

	if (!$_POST['name'])
		return_error('A category needs a name');

	$id = $_POST['id'];
	$name = trim($_POST['name']);

	if(!is_numeric($id) || $id <= 0)
		return_error('Invalid category id');

	if(isset($_POST['parent'])) {
		$parent = $_POST['parent'];
		if(!is_numeric($parent) || $parent <= 0)
			return_error('Invalid parent category');
	} else
		$parent = null;

	try {
		$category_id = editCategory($id, $name, $parent);
		http_response_code(200);
	} catch (PDOException $e) {
		return_error("An error occurred while editing the category. Please try again." . $e->getMessage());
	}

	function return_error($error) {
		//http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>