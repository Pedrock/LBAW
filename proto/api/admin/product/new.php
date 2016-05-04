<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	$errors = array();

	if (!$_POST['name'])
		$errors['name'] = 'Please enter a product name';
	else {
		$name = trim($_POST['name']);

		if($name == '')
			$errors['name'] = 'Please enter a product name';
	}

	if (!$_POST['price'] )
		$errors['price'] = 'Please enter a price';
	else {
		$price = trim($_POST['price']);

		if(!is_numeric($price) || $price < 0)
			$errors['price'] = "The price must be a non-negative number";
	}
	
	if (!$_POST['stock'])
		$errors['stock'] = 'Please enter a stock';
	else {
		$stock = trim($_POST['stock']);

		if(!is_numeric($stock) || $stock < 0)
			$errors['stock'] = "The stock must be a non-negative number";
	}
	
	if (!$_POST['weight'])
		$errors['weight'] = 'Please enter a weight';
	else {
		$weight = trim($_POST['weight']);

		if(!is_numeric($weight) || $weight < 0)
			$errors['weight'] = "The weight must be a non-negative number";
	}
	
	if (!$_POST['description'])
		$errors['description'] = 'Please enter a description';
	else {
		$description = $_POST['description'];

		if($description == '')
			$errors['description'] = 'Please enter a product description';
	}
	
	if (!$_POST['categories'])
		$errors['categories'] = 'The product needs at least one category';
	else {
		$categories = $_POST['categories'];
	}
	
	/*if(!isset($_FILES['files']))
		$errors['files'] = 'The product needs at least one photo';
	else {
		// The files
		$num_files = count($_FILES['files']['tmp_name']);
		$src = array();
		$dst = array();
		$images_path = $BASE_DIR . 'images/products/';
		
		for($i = 0; $i < $num_files; $i++) {
			$source = $_FILES['files']['tmp_name'][$i];
			if($source == '') {
				$errors['files'] = 'One of the photos isn\'t valid';
				break;
			}
			$img_info = getimagesize($source);
			if(strpos($img_info['mime'], 'image') !== 0) {
				$errors['files'] = 'One of the photos isn\'t a valid image'; // TODO say which?
				break;
			}

			$img_size = filesize($source);
			if($img_size > 1024000) { // FIXME 1MB?
				$errors['files'] = 'One of the photos is too large (>1MB)'; // TODO say which?
				break;
			}
			$file_extension = str_ireplace('image/', '', $img_info['mime']);
			$target = ($i + 1) . '.' . $file_extension;
			array_push($src, $source);
			array_push($dst, $target);
		}
	}*/
	
	if (!empty($errors))
		return_errors($errors);

	try {
		$product_id = createProduct($name, $price, $stock, $weight, $description, $categories, true);
		//addProductPhotos($product_id, $dst);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the product. Please try again." . $e->getMessage());
	}

	// $images_path = $images_path . '/' . $product_id . '_';
	// for($i = 0; $i < $num_files; $i++)
	// 	move_uploaded_file($src[$i], $images_path . $dst[$i]);

	echo json_encode(array('id' => $product_id));

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