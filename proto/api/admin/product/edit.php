<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['id'] || !$_POST['name'] || !$_POST['price']  || !$_POST['stock'] || !$_POST['weight'] || !$_POST['description'])
		return_error('All fields are mandatory');

	if (!$_POST['categories'])
		return_error('The product needs at least one category');

	$errors = array();

	$name = trim($_POST['name']);
	$price = trim($_POST['price']);
	$stock = trim($_POST['stock']);
	$weight = trim($_POST['weight']);
	$description = $_POST['description'];
	$categories = $_POST['categories'];
	$id = $_POST['id'];

	$deleted = (isset($_POST['deleted']) && $_POST['deleted'] == true) ? 'true' : 'false';

	if(!is_numeric($price) || $price < 0)
		$errors['price'] = "The price must be a non-negative number";

	if(!is_numeric($stock) || $stock < 0)
		$errors['stock'] = "The stock must be a non-negative number";

	if(!is_numeric($weight) || $weight < 0)
		$errors['weight'] = "The weight must be a non-negative number";

	if (!empty($errors))
		return_errors($errors);

	try {
		editProduct($id, $name, $price, $stock, $weight, $description, $categories, $deleted);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the product. Please try again." . $e->getMessage());
	}

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