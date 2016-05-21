<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/cart.php');

if (empty($_POST['product']))
{
    http_response_code(400);
    die();
}
else if (empty($_SESSION["user"]))
{
    http_response_code(401);
    die();
}

removeProductFromCart($_POST['product'], $_SESSION["user"]);

?>