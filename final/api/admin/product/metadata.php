<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	// Action
	if(!isset($_POST['action']))
		return_error('Invalid action');

	$action = $_POST['action'];

	// Product id
	if(!isset($_POST['product']))
		return_error('No product id specified');

	$product = $_POST['product'];

	if(!is_numeric($product))
		return_error('Invalid product id');

	// Category id
	if(!isset($_POST['cat']))
		return_error('No category id  specified');

	$cat_id = $_POST['cat'];

	if(!is_numeric($cat_id))
		return_error('Invalid category id');

	if($action == 'edit' || $action == 'create') {
		if(!isset($_POST['description']))
			return_error('No description specified');

		$description = $_POST['description'];

		if($description == '')
			return_error('Description can\'t be empty');
	}

	try {
		if($action == 'create') {
			createMetadata($product, $cat_id, $description);
		} else if($action == 'edit') {
			editMetadata($product, $cat_id, $description);
		} else if($action == 'delete') {
			deleteMetadata($product, $cat_id);
		} else
			return_error('Invalid action');
	} catch (PDOException $e) {
		return_error($e->getMessage());
	}

	echo json_encode(array('success' => $cat_id));

	function return_error($error) {
		http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}

	function return_errors($error) {
		http_response_code(422);
		echo json_encode(array('errors' => $error));
		die();
	}
?>