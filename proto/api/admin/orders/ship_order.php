<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'lib/admin_check.php');
include_once($BASE_DIR . 'database/products.php');

$order_id = trim($_POST['order_id']);

try {
    shipOrder($order_id);
    http_response_code(200);
    echo json_encode(getOrderStatus($order_id));
} catch (PDOException $e) {
    http_response_code(400);
}
?>