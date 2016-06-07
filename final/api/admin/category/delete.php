<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['id'])
		return_error('A category id must be specified');

	$id = $_POST['id'];

	if(!is_numeric($id) || $id <= 0)
		return_error('Invalid category id');

	try {
		$category_id = deleteCategory($id);
		http_response_code(200);
	} catch (PDOException $e) {
		return_error("An error occurred while deleting the category. Please try again." . $e->getMessage());
	}

	function return_error($error) {
		http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>