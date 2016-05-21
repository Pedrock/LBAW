<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/cart.php');

if (empty($_POST['product']) || empty($_POST['quantity']))
{
    http_response_code(400);
    die();
}
else if (empty($_SESSION["user"]))
{
    http_response_code(401);
    die();
}

updateCartProductQuantity($_POST['product'], $_SESSION["user"], $_POST['quantity']);

?>