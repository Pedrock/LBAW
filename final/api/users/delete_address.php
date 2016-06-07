<?php
include_once('../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

$idUser = $_SESSION['user'];
if (empty($idUser))
{
    http_response_code(401);
    die();
}

$address_id = trim($_POST['address_id']);

try {
    deleteAddress($address_id);
    http_response_code(200);
} catch (PDOException $e) {
    http_response_code(400);
}
?>