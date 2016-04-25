<?php
	if(!isset($_SESSION['user'])) {
		http_response_code(403);
		header('Location: ' . $BASE_URL . 'pages/login.php?admin');
		die();
	} else if(!isset($_SESSION['admin'])) {
		$_SESSION['admin'] = isAdmin($_SESSION['user']);
	} 

	if(!$_SESSION['admin']) {
		http_response_code(403);
		header('Location: ' . $BASE_URL . 'pages/index.php');
		die();
	}
?>