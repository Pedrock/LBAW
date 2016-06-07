<?php
if(empty($_SESSION['user'])) {
	http_response_code(403);
	header('Location: ' . $BASE_URL . 'pages/login.php');
	die();
}
?>