<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'lib/admin_check.php');
include_once($BASE_DIR . 'database/products.php');

$order_id = $_POST['order_id'];
$status = trim($_POST['status']);

try {
    updateOrderStatus($order_id, $status);
    http_response_code(200);
    echo json_encode(getOrderStatus($order_id));
} catch (PDOException $e) {
    http_response_code(400);
}
?>