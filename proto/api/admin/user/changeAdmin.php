<?php
	include_once('../../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	if (!$_POST['user'])
		return_error('A user must be specified');

	$user = trim($_POST['user']);
	if($user == "")
		return_error('A user must be specified');

	$setAdmin = trim($_POST['setAdmin']);
	if($setAdmin == "")
		return_error('An action must be specified');

	try {
		$userinfo =  getUserInfoFromNameOrEmail($user);
		if($userinfo === false)
			return_error("User " . $user . "does not exist", 404);
		changeAdminStatus($user, $setAdmin);
		$success = ($userinfo['isadmin'] != ($setAdmin === "true"));
		http_response_code(200);
		echo json_encode(array('success' => $success, 'isadmin' => $userinfo['isadmin'], 'setAdmin' => $setAdmin));
	} catch (PDOException $e) {
		return_error("An error occurred while editing user. Please try again." . $e->getMessage());
	}

	function return_error($error, $error_code = 422) {
		http_response_code($error_code);
		echo json_encode(array('error' => $error));
		die();
	}
?>