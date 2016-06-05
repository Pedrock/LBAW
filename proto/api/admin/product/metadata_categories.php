<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if(!isset($_POST['action']))
		return_error('Invalid action');

	$action = $_POST['action'];

	if($action != 'create') {
		if(!isset($_POST['id']))
			return_error('No id specified');

		$id = $_POST['id'];

		if(!is_numeric($id))
			return_error('Invalid id');
	}

	if($action == 'edit' || $action == 'create') {
		if(!isset($_POST['description']))
			return_error('No description specified');

		$name = $_POST['description'];

		if($name == '')
			return_error('Description can\'t be empty');
	}

	try {
		if($action == 'create') {
			$id = createMetadataCategory($name);
		} else if($action == 'edit') {
			editMetadataCategory($id, $name);
		} else if($action == 'delete') {
			deleteMetadataCategory($id);
		} else
			return_error('Invalid action');
	} catch (PDOException $e) {
		return_error($e->getMessage());
	}

	echo json_encode(array('success' => $id));

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