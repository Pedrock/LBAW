<?php
	include_once('../config/init.php');

	if (!$_GET['id'] || !$_GET['token']) {
		http_response_code(403);
		$error = true;
	} else {
		$id = $_GET['id'];
		$token = $_GET['token'];

		$user_id = validResetToken($id, $token);

		if(!$user_id)
			$error = true;
		else
			$user_id = $user_id['id'];
	}
	
	if($error) {
		$smarty->assign('error', "Invalid password reset token.");
	} else {
		$smarty->assign('id', $user_id);
		$smarty->assign('token', $token);
	}

	$smarty->display('auth/reset_password.tpl');
?>
