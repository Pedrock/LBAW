<?php
include_once('../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

$idUser = $_SESSION['user'];
if (empty($idUser))
{
    http_response_code(401);
    die();
}

    $name = trim($_POST['name']);
    $addr1 = trim($_POST['addr1']);
    $addr2 = trim($_POST['addr2']);
    $phone = trim($_POST['phone']);
    $zip1 = trim($_POST['zip1']);
    $zip2 = trim($_POST['zip2']);

try {
    $idAddress = addAddress($idUser, $name, $addr1, $addr2, $phone, $zip1, $zip2);
    http_response_code(200);
    echo json_encode($idAddress);
} catch (PDOException $e) {
    http_response_code(400);
}
?>