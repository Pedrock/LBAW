<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['id'] || !$_POST['name'] || !$_POST['price']  || !$_POST['stock'] || !$_POST['weight'] || !$_POST['description'])
		return_error('All fields are mandatory');

	if (!$_POST['categories'])
		return_error('The product needs at least one category');

	$errors = array();

	//if(!isset($_FILES['files']))
	//	$errors['files'] = 'The product needs at least one photo';

	$name = trim($_POST['name']);
	$price = trim($_POST['price']);
	$stock = trim($_POST['stock']);
	$weight = trim($_POST['weight']);
	$description = $_POST['description'];
	$categories = $_POST['categories'];
	$id = $_POST['id'];

	if(!is_numeric($price) || $price < 0)
		$errors['price'] = "The price must be a non-negative number";

	if(!is_numeric($stock) || $stock < 0)
		$errors['stock'] = "The stock must be a non-negative number";

	if(!is_numeric($weight) || $weight < 0)
		$errors['weight'] = "The weight must be a non-negative number";

	// The files
	/*$num_files = count($_FILES['files']['tmp_name']);
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
	*/
	if (!empty($errors))
		return_errors($errors);

	try {
		editProduct($id, $name, $price, $stock, $weight, $description, $categories);
		http_response_code(201);
	} catch (PDOException $e) {
		return_error("An error occurred while creating the product. Please try again." . $e->getMessage());
	}

	/*$images_path = $images_path . '/' . $product_id . '_';
	for($i = 0; $i < $num_files; $i++)
		move_uploaded_file($src[$i], $images_path . $dst[$i]);
*/
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