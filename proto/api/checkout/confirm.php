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

$idUser = $_SESSION['user'];

$matches = array();

if (!empty($_POST['ship_addr'])) {
    $shipping_address_id = $_POST['ship_addr'];
}
else if (!empty($_POST['shipping_name']) && !empty($_POST['shipping_addr1'])
    && isset($_POST['shipping_addr2']) && !empty($_POST['shipping_zip'])
    && preg_match( '/^([0-9]{4})\-([0-9]{3})$/' , $_POST['shipping_zip'], $matches) && count($matches) == 3
    && !empty($_POST['shipping_phone']))
{
    $name = $_POST['shipping_name'];
    $address1 = $_POST['shipping_addr1'];
    $address2 = $_POST['shipping_addr2'];
    $zip1 = $matches[1];
    $zip2 = $matches[2];
    $phoneNumber = $_POST['shipping_phone'];
    $shipping_address_id = addAddress($idUser, $name, $address1, $address2, $phoneNumber, $zip1, $zip2);
}
else {
    http_response_code(400);
    die();
}

if (!empty($_POST['same'])) {
    $billing_address_id = $shipping_address_id;
}
else if (!empty($_POST['bill_addr'])) {
    $billing_address_id = $_POST['ship_addr'];
}
else if (!empty($_POST['billing_name']) && !empty($_POST['billing_addr1'])
    && isset($_POST['billing_addr2']) && !empty($_POST['billing_zip'])
    && preg_match( '/^([0-9]{4})\-([0-9]{3})$/' , $_POST['billing_zip'], $matches) && count($matches) == 3
    && !empty($_POST['billing_phone']))
{
    $name = $_POST['billing_name'];
    $address1 = $_POST['billing_addr1'];
    $address2 = $_POST['billing_addr2'];
    $zip1 = $matches[1];
    $zip2 = $matches[2];
    $phoneNumber = $_POST['billing_phone'];
    $billing_address_id = addAddress($idUser, $name, $address1, $address2, $phoneNumber, $zip1, $zip2);
}
else {
    http_response_code(400);
    die();
}

$shipping_address = getUserAddress($idUser, $shipping_address_id);
$billing_address = getUserAddress($idUser, $billing_address_id);

if ($shipping_address == false || $billing_address == false)
{
    http_response_code(400);
    die();
}

$nif = $_POST['nif'];

$order_id = makeOrder($idUser, $billing_address_id, $shipping_address_id, $nif, $_SESSION['coupon']);
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

$total_without_discount = 0;

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
    $total_without_discount += $product['price']*$product['quantity'];
}

$subtotal = $costs['totalprice']-$costs['shippingcost'];

if ($costs['coupon_discount'])
{
    $discount = new Item();
    $discount->setName('Coupon Code Discount')
        ->setDescription('Code: '.$_SESSION['coupon'])
        ->setCurrency('EUR')
        ->setQuantity(1)
        ->setTax(0.23)
        ->setPrice($subtotal-$total_without_discount);
    array_push($items, $discount);
}

$itemList = new ItemList();
$itemList->setItems($items)
    ->setShippingAddress($shippingAddress);

$details = new Details();
$details->setShipping($costs['shippingcost'])
    ->setSubtotal($subtotal);

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
    echo parseApiError($ex->getData());
    exit(1);
}