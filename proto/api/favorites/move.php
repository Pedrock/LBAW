<?php  
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (empty($_SESSION['user']))
{
	http_response_code(401);
	die();
}

$product = $_POST['product'];
$new_list = $_POST['new_list'];
if ($new_list == "") $new_list = NULL;

try {
	moveFavorite($_SESSION['user'],$product,$new_list);
	http_response_code(200);
} catch (PDOException $e) {
	http_response_code(400);
}

?>