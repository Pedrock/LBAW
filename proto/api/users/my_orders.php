<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');
	include_once($BASE_DIR . 'database/cart.php');
	if (empty($_SESSION['user']))
	{
		http_response_code(401);
		die();
	}

	$order_id = $_POST['order_id'];

	if(!isset($_POST['action'])){
		try {
			list($order_info, $order_products) = getInfoPurchaseHistory($_SESSION['user'],$order_id);
			http_response_code(200);
			$order_info['products'] = $order_products;
			$order_info['order_id'] = $order_id;
			echo json_encode($order_info);
		} catch (PDOException $e) {
			http_response_code(400);
		}
	} else {
		
		if($_POST['action'] === "add"){
			try {
				$success = addPreviousOrder($_SESSION['user'], $order_id);
				
				http_response_code(200);
				echo json_encode(['success' => $success]);
			} catch (PDOException $e) {
				http_response_code(400);
				echo json_encode(['success' => false, 'user' => $_SESSION['user'], 'order' => $order_id]);
			}
		} else {
			echo json_encode(['success' => false, 'action'=> $_POST['action'], 'user' => $_SESSION['user'], 'order' => $order_id]);
		}
	}
?>