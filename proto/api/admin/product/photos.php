<?php
	$thumbSize = 280;
	$maxSize = 1000;

	$images_path = '../../../images/products/';

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
		$source = $_FILES['file']['tmp_name'];

		if($source == '')
			return_error('The photo isn\'t valid');

		$img_info = getimagesize($source);

		if(strpos($img_info['mime'], 'image') !== 0)
			return_error('The photo isn\'t a valid image');

		$img_size = filesize($source);

		// Generate name, based on photo
		$photo_name = $id . "_" . md5_file($source) . ".jpg";
		if(file_exists($images_path . $photo_name))
			return_error("Photo already exists");

		try {
			addProductPhoto($id, $order, $photo_name);
			http_response_code(201);
		} catch (PDOException $e) {
			return_error("An error occurred while adding the photo. Please try again." . $e->getMessage());
		}

		processImage($source, $images_path, $photo_name);

		echo json_encode(array('success' => $photo_name));
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
			$filename = deleteProductPhoto($id, $order);
			unlink($images_path . $filename);
			unlink($images_path . 'thumb_' . $filename);
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

	function processImage($src, $dst_path, $dst_file) {
		global $thumbSize;
		global $maxSize;

		list($width, $height) = getimagesize($src);

		$imgContent = file_get_contents($src);
		$final_img = $img = imagecreatefromstring($imgContent);

		if ($width > $height) {
			$x = ($width - $height) / 2;
			$y = 0;
			$smallest = $height;
		} else {
			$x = 0;
			$y = ($height - $width) / 2;
			$smallest = $width;
		}

		$thumb = imagecreatetruecolor($thumbSize, $thumbSize);
		imagecopyresampled($thumb, $img, 0, 0, $x, $y, $thumbSize, $thumbSize, $smallest, $smallest);

		imagejpeg($thumb, $dst_path . 'thumb_' . $dst_file);

		if($width > $maxSize || $height > $maxSize) {
			$percentage = $maxSize / ($width > $maxSize ? $width : $height);

			$newwidth = $width * $percentage;
			$newheight = $height * $percentage;
		
			$final_img = imagecreatetruecolor($newwidth, $newheight);
			imagecopyresized($final_img, $img, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
		}

		imagejpeg($final_img, $dst_path . $dst_file);
	}
?>