<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'lib/admin_check.php');
include_once($BASE_DIR . 'database/products.php');

if (empty($_POST['status']) || empty($_POST['order_id']) || empty($_POST['product_id']))
{
    http_response_code(400);
    die();
}

$status = trim($_POST['status']);

try {
    updateProductOrder($_POST['order_id'], $_POST['product_id'], $status);
    echo json_encode(getOrderStatus($_POST['order_id']));
} catch (PDOException $e) {
    http_response_code(400);
}
?>