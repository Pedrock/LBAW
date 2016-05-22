<?php  
include_once('../../config/init.php');
include_once($BASE_DIR .'database/cart.php');

function validPostNumber($var)
{
	return (!empty($var) && is_numeric($var));
}

if (!validPostNumber($_POST['product']) || !validPostNumber($_POST['quantity']))
{
	http_response_code(400);
	die();
}

if (empty($_SESSION["user"]))
{
	if (!empty($_COOKIE['cart']))
		$products = explode(';', $_COOKIE['cart']);
	else
		$products = array();

	$add = true;
	$length = count($products);
	for ($i = 0; $i < $length; $i++)
	{
		list($product_id,$product_quantity) = explode(':',$products[$i],2);
		if ($product_id == $_POST['product'])
		{
			$products[$i] = $_POST['product'].':'.($product_quantity+$_POST['quantity']);
			$add = false;
			break;
		}
	}
	if ($add)
		array_push($products, $_POST['product'].':'.$_POST['quantity']);
	$cookie = implode(";",$products);
	setcookie('cart', $cookie, 2147483647, $BASE_URL);

}
else
	addProductToCart($_POST['product'], $_SESSION["user"], $_POST['quantity']);

?>