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

		if(!is_numeric($weight) || $weight < 0 || is_decimal($weight))
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
	
	if (!empty($errors))
		return_errors($errors);

	try {
		$product_id = createProduct($name, $price, $stock, $weight, $description, $categories, true);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the product. Please try again." . $e->getMessage());
	}

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

	function is_decimal($val) {
		return is_numeric($val) && floor($val) != $val;
	}
?>