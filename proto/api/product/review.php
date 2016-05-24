<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/products.php');

	if (empty($_SESSION['user']))
	{
		http_response_code(401);
		die();
	}

	$product_id = trim($_POST['product_id']);
	$score = trim($_POST['score']);
	$body = trim($_POST['body']);

	try {
		$date = createProductReview($product_id, $_SESSION['user'], $score, $body);
		$averagescore = getScoreProduct($product_id);
		http_response_code(200);
		echo json_encode(array('date' => $date,'averagescore' => $averagescore));
	} catch (PDOException $e) {
		http_response_code(400);
	}
	?>