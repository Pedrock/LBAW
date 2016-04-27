<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if(!isset($_FILES['file']))
		return_error('The product needs at least one photo');

	// The files
	$num_files = count($_FILES['files']['tmp_name']);

	$src = array();
	$dst = array();

	$images_path = '../../images/products/temp/';

	for($i = 0; $i < $num_files; $i++) {
		$source = $_FILES['files']['tmp_name'][$i];

		if($source == '')
			return_error('One of the photos isn\'t valid');

		$img_info = getimagesize($source);

		if(strpos($img_info['mime'], 'image') !== 0)
			return_error('One of the photos isn\'t a valid image');

		$img_size = filesize($source);

		if($img_size > 1024000) // FIXME 1MB?
			return_error('One of the photos is too large (>1MB)');

		$file_extension = str_ireplace('image/', '', $img_info['mime']);

		$target = '.' . $file_extension;

		array_push($src, $source);
		array_push($dst, $target);
	}

	try {
		$product_id = createEmptyProduct();
		//addProductPhotos($product_id, $dst);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the product. Please try again." . $e->getMessage());
	}

	$images_path = $images_path . '/' . $product_id . '_';

	for($i = 0; $i < $num_files; $i++)
		move_uploaded_file($src[$i], $images_path . $dst[$i]);

	echo json_encode(array('success' => $product_id));

	function return_error($error) {
		//http_response_code(422);
		echo json_encode(array('error' => $error));
		die();
	}
?>