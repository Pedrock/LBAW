<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/users.php');
	include_once($BASE_DIR .'lib/cart_cookie_to_db.php');

	if (!$_POST['password'] || !$_POST['token'] || !$_POST['id']) 
		return_error('Missing POST data', 400);
	
	$email = $_POST['email'];

  	if (strlen($_POST['password']) < 6)
  		return_error("The new password must have at least 6 characters.");

	try {
		resetPassword($_POST['id'], $_POST['password'], $_POST['token']);
	} catch (PDOException $e) {
		return_error("Failed to reset password");
	}

	echo json_encode(array('success' => 'success'));

	function return_error($error, $code = 422) {
		http_response_code($code);
		echo json_encode(array('error' => $error));
		die();
	}
?>