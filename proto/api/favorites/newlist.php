<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (empty($_SESSION['user']))
{
    http_response_code(401);
    die();
}

$list_name = trim($_POST['list_name']);
if ($list_name == "")
{
    http_response_code(400);
    die();
}

try {
    $id = createFavoriteList($_SESSION['user'],$list_name);
    http_response_code(200);
    echo json_encode($id);
} catch (PDOException $e) {
    http_response_code(400);
}

?>
