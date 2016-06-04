<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/user_check.php');
include_once($BASE_DIR .'lib/paypal.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/products.php');
include_once($BASE_DIR .'database/cart.php');

use PayPal\Api\Amount;
use PayPal\Api\Payer;
use PayPal\Api\PayerInfo;
use PayPal\Api\ShippingAddress;
use PayPal\Api\Payment;
use PayPal\Api\Transaction;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Details;

if (!empty($_POST['ship_addr'])) {
    $shipping_address_id = $_POST['ship_addr'];
    $shipping_address = getUserAddress($_SESSION['user'], $shipping_address_id);
}
else {
    $shipping_address = array(
        'name' => $_POST['shipping_name'],
        'address1' => $_POST['shipping_addr1'],
        'address2' => $_POST['shipping_addr2'],
        'zipcode' => $_POST['shipping_zip'],
        'city' => $_POST['shipping_city'],
        'phonenumber' => $_POST['shipping_phone']
    );
}

if (!empty($_POST['same'])) {
    $billing_address_id = $shipping_address_id;
    $billing_address = getUserAddress($_SESSION['user'], $billing_address_id);
}
else if (!empty($_POST['bill_addr'])) {
    $billing_address_id = $_POST['ship_addr'];
    $billing_address = getUserAddress($_SESSION['user'], $billing_address_id);
}
else {
    $billing_address = array(
        'name' => $_POST['billing_name'],
        'address1' => $_POST['billing_addr1'],
        'address2' => $_POST['billing_addr2'],
        'zipcode' => $_POST['billing_zip'],
        'city' => $_POST['billing_city'],
        'phonenumber' => $_POST['billing_phone']
    );
    throw new Exception('Not implemented');
}

$nif = $_POST['nif'];

$order_id = makeOrder($_SESSION['user'], $billing_address_id, $shipping_address_id, $nif, NULL); // TODO - Coupon
$products = getOrderProducts($order_id);
$costs = getOrderCosts($order_id);

// Add Shipping Address
$shippingAddress = new ShippingAddress();
$shippingAddress->setRecipientName($shipping_address['name'])
    ->setLine1($shipping_address['address1'])
    ->setLine2($shipping_address['address2'])
    ->setCity($shipping_address['city'])
    ->setPostalCode($shipping_address['zipcode'])
    ->setCountryCode('PT');

$payerInfo = new PayerInfo();
$payerInfo->setShippingAddress($shippingAddress);

$payer = new Payer();
$payer->setPayerInfo($payerInfo);
$payer->setPaymentMethod("paypal");

$items = array();

foreach ($products as $row => $product)
{
    $item = new Item();
    $item->setSKu($product['id'])
        ->setName($product['name'])
        ->setDescription($product['name'])
        ->setCurrency('EUR')
        ->setQuantity($product['quantity'])
        ->setTax(0.23)
        ->setPrice($product['price']);
    array_push($items, $item);
}

//$discount = new Item(); // TODO - Coupon
//$discount->setName('Coupon Code')
//    ->setDescription('Coupon Code')
//    ->setCurrency('EUR')
//    ->setQuantity(1)
//    ->setTax(0)
//    ->setPrice(-17.5);

$itemList = new ItemList();
$itemList->setItems($items)
    ->setShippingAddress($shippingAddress);

$details = new Details();
$details->setShipping($costs['shippingcost'])
    ->setSubtotal($costs['totalprice']-$costs['shippingcost']);


$amount = new Amount();
$amount->setCurrency("EUR")
    ->setTotal($costs['totalprice'])
    ->setDetails($details);

$transaction = new Transaction();
$transaction->setAmount($amount)
    ->setItemList($itemList)
    ->setDescription("Payment description")
    ->setInvoiceNumber(uniqid());

$redirectUrls = new RedirectUrls();
$redirectUrls->setReturnUrl($LINK.$BASE_URL."pages/checkout/order_completion.php?orderId=$order_id&success=true");
$redirectUrls->setCancelUrl($LINK.$BASE_URL."pages/checkout/order_completion.php?orderId=$order_id&success=false");

$payment = new Payment();
$payment->setRedirectUrls($redirectUrls)
    ->setIntent("sale")
    ->setPayer($payer)
    ->setTransactions(array($transaction));

try {
    $payment->create(getApiContext());
    $link = $payment->getLink('approval_url');
    if (empty($link))
    {
        http_response_code(422);
        die();
    }
    http_response_code(200);
    echo json_encode($link);
} catch (Exception $ex) {
    http_response_code(400);
    exit(1);
}