<?php
include_once('../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

$idUser = $_SESSION['user'];
if (empty($idUser))
{
    http_response_code(401);
    die();
}

$idAddress = $_POST['id'];
$name = trim($_POST['name']);
$address1 = trim($_POST['addr1']);
$address2 = trim($_POST['addr2']);
$phoneNumber = trim($_POST['phone']);
$zip1 = trim($_POST['zip1']);
$zip2 = trim($_POST['zip2']);

try {
    $result = editAddress($idAddress, $name, $address1, $address2, $phoneNumber, $zip1, $zip2);
    if ($result === false) return http_response_code(422);
    http_response_code(200);
} catch (PDOException $e) {
    http_response_code(400);
    var_dump($e);
}
?>