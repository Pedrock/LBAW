<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/users.php');

	if (!$_POST['email']) 
		return_error("Please enter an email", 400);
	
	$email = $_POST['email'];

	$token = bin2hex(openssl_random_pseudo_bytes(32));

	try {
		$user_id = startPasswordRecovery($email, $token);
	} catch (PDOException $e) {
		return_error("Email/Username not found");
	}

	// Send the mail
	$subject = 'Reset your password';
	$headers   = array();
	$headers[] = "MIME-Version: 1.0";
	$headers[] = "Content-type: text/html; charset=utf-8";
	$headers[] = "From: HashStore <noreply@hashstore>";
	$headers[] = "Subject: {$subject}";
	$headers[] = "X-Mailer: PHP/" . phpversion();
	
	$reset_url = $LINK . $BASE_URL . "pages/reset_password.php?id=" . $user_id . "&token=" . $token;

	$message = "<h1>HashStore - Password Reset</h1>"
	. "A request was made to reset your password.<br><br>"
	. "Follow this link to reset your password:\r\n"
	."<a href=\"" . $reset_url . "\">Reset Password</a><br><br>"
	. "If you didn't ask for your password to be reset please disregard this email.";

	mail($email, $subject, $message, implode("\r\n", $headers));

	echo json_encode(array('success' => 'success'));

	function return_error($error, $code = 422) {
		http_response_code($code);
		echo json_encode(array('error' => $error));
		die();
	}
?>