<?php
include_once('../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!empty($_GET['zip1']) && is_numeric($_GET['zip1'])
    && !empty($_GET['zip1']) && is_numeric($_GET['zip1']))
{
    echo json_encode(getCity($_GET['zip1'], $_GET['zip2']));
    return;
}
else http_response_code(400);

