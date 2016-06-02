<?php
    include_once('../../../config/init.php');
    include_once($BASE_DIR . 'lib/admin_check.php');
    include_once($BASE_DIR . 'database/products.php');

    $order_id = trim($_POST['order_id']);

    try {
        list($order_info, $order_products) = getInfoShipments($order_id);
        http_response_code(200);
        $order_info['products'] = $order_products;
        echo json_encode($order_info);
    } catch (PDOException $e) {
        http_response_code(400);
    }
?>