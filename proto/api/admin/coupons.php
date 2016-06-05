<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if(!isset($_POST['action']))
		return_error('Invalid action');

	$action = $_POST['action'];

	if(!isset($_POST['id']))
		return_error('No id specified');

	$id = $_POST['id'];

	if(!is_numeric($id))
		return_error('Invalid id');

	if($action == 'edit' || $action == 'create') {
		if(!isset($_POST['percentage']))
			return_error('No percentage specified');

		if(!isset($_POST['start']))
			return_error('No start specified');

		if(!isset($_POST['end']))
			return_error('No end specified');

		$percentage = $_POST['percentage'];
		$start = $_POST['start'];
		$end = $_POST['end'];

		if(strtotime($start) > strtotime($end))
			return_error('End date must be after start date');

		if(!is_numeric($percentage) || $percentage < 0 | $percentage > 100)
			return_error('Invalid percentage');
	}

	try {
		if($action == 'create') {
			$id = createCoupon($id, $_SESSION['user'], $percentage, $start, $end);
		} else if($action == 'edit') {
			editCoupon($id, $percentage, $start, $end);
		} else if($action == 'delete') {
			deleteCoupon($id);
		} else
			return_error('Invalid action');
	} catch (PDOException $e) {
		if (strpos($e->getMessage(), 'overlaps') !== false)
			return_error('Coupon overlaps with another');
		else
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