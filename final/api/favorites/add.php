<?php  
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (empty($_SESSION['user']))
{
	http_response_code(401);
	die();
}

$product = trim($_POST['product']);

try {
	addToFavorites($_SESSION['user'],$product);
	http_response_code(200);
} catch (PDOException $e) {
	http_response_code(400);
}

?>