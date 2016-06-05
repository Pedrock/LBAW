<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');

	if (empty($_SESSION['user']))
	{
		http_response_code(401);
		die();
	}

	$order_id = $_POST['order_id'];

	try {
		list($order_info, $order_products) = getInfoPurchaseHistory($_SESSION['user'],$order_id);
		http_response_code(200);
		$order_info['products'] = $order_products;
		echo json_encode($order_info);
	} catch (PDOException $e) {
		http_response_code(400);
	}
?>