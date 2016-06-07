<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (empty($_SESSION['user']))
{
    http_response_code(401);
    die();
}

$list_id = trim($_POST['list_id']);
if ($list_id == "")
{
    http_response_code(400);
    die();
}

try {
    deleteFavoriteList($_SESSION['user'],$list_id);
    http_response_code(200);
} catch (PDOException $e) {
    http_response_code(400);
}

?>
