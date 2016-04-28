<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['id'])
		return_error('No product specified');

	$id = $_POST['id'];

	if(!is_numeric($id) || $id < 0)
		$errors['id'] = "The id must be a non-negative number";

	//$photos = getProductPhotos($id);

	try {
		deleteProduct($id);
		//addProductPhotos($product_id, $dst);
		http_response_code(200);
	} catch (PDOException $e) {
		return_error("An error occurred while deleting the product. Please try again." . $e->getMessage());
	}

	/*if($photos != null && count($photos) > 0) {
		$images_path = $BASE_DIR . 'images/products/';
		foreach($photos as $photo)
			unlink($image_path . $photo['location']);
	}*/

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