<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if(!isset($_POST['action']))
		return_error('No action specified');
	else
		$action = $_POST['action'];

	if(!isset($_POST['id']))
		return_error('No product id specified');
	else
		$id = $_POST['id'];

	if(!isset($_POST['order']))
		return_error('No order specified');
	else
		$order = $_POST['order'];

	if($action == 'add') {
		if(!isset($_FILES['file']))
			return_error('No file specified for action ' . $action);

		// The file
		$images_path = '../../../images/products/';

		$source = $_FILES['file']['tmp_name'];

		if($source == '')
			return_error('The photo isn\'t valid');

		$img_info = getimagesize($source);

		if(strpos($img_info['mime'], 'image') !== 0)
			return_error('The photo isn\'t a valid image');

		$img_size = filesize($source);

		if($img_size > 1024000) // FIXME resize photo + generate thumbnails?
			return_error('The photo is too large (>1MB)');

		$file_extension = str_ireplace('image/', '', $img_info['mime']);

		// Generate random, unique name
		$photo_name = bin2hex(openssl_random_pseudo_bytes(8));
		while(file_exists($images_path . $photo_name . '.' . $file_extension))
			$photo_name = bin2hex(openssl_random_pseudo_bytes(8));

		try {
			addProductPhoto($id, $order, $photo_name . '.' . $file_extension);
			http_response_code(201);
		} catch (PDOException $e) {
			return_error("An error occurred while adding the photo. Please try again." . $e->getMessage());
		}

		echo json_encode(array('success' => 'success'));

		move_uploaded_file($source, $images_path . $photo_name . '.' . $file_extension);
	} else if($action == 'edit') {
		if(!isset($_POST['new_order']))
			return_error('No new_order specified');
		else
			$new_order = $_POST['new_order'];

		try {
			editProductPhoto($id, $order, $new_order);
			http_response_code(201);
		} catch (PDOException $e) {
			return_error("An error occurred while editting the photo. Please try again." . $e->getMessage());
		}

		echo json_encode(array('success' => 'success'));
	} else if($action == 'delete') {
		try {
			deleteProductPhoto($id, $order);
			http_response_code(201);
		} catch (PDOException $e) {
			return_error("An error occurred while deleting the photo. Please try again." . $e->getMessage());
		}

		echo json_encode(array('success' => 'success'));
	} else {
		return_error('Invalid action');
	}

	function return_error($error) {
		http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>