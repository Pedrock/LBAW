<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (empty($_POST['user']) || empty($_POST['setAdmin']))
		return_error('Bad Request', 400);

	$user = trim($_POST['user']);
	if($user == "")
		return_error('A user must be specified', 400);

	$setAdmin = trim($_POST['setAdmin']);
	if($setAdmin == "")
		return_error('An action must be specified', 400);

	try {
		$success = changeAdminStatus($user, $setAdmin);
		http_response_code(200);
		echo json_encode(array('success' => $success));
	} catch (PDOException $e) {
		return_error("An error occurred while editing user. Please try again.");
	}

	function return_error($error, $error_code = 422) {
		http_response_code($error_code);
		echo json_encode(array('error' => $error));
		die();
	}
?>