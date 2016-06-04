<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/paypal.php');
include_once($BASE_DIR .'database/cart.php');
include_once($BASE_DIR .'database/products.php');

use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;

if(isset($_GET['success'])) {

    if($_GET['success'] == 'true' && isset($_GET['PayerID']) && isset($_GET['paymentId'])) {
        $orderId = $_GET['orderId'];
        try {
            $result = prepareOrderPayment($orderId);
            if ($result === false) throw new Exception('Invalid Order');
            $payment = executePayment($_GET['paymentId'], $_GET['PayerID']);
            finishOrderPayment();
            $messageType = "success";
            $message = "Your payment was successful. Your order id is $orderId.";
            clearCart($_SESSION['user']);
        } catch (\PayPal\Exception\PPConnectionException $ex) {
            cancelOrderPayment();
            $message = parseApiError($ex->getData());
            $messageType = "error";
        } catch (Exception $ex) {
            cancelOrderPayment();
            $message = $ex->getMessage();
            if ($ex->getCode() == 23514)
            {
                $message = "Not enough stock.";
            }
            $messageType = "error";
        }
    } else {
        $messageType = "error";
        $message = "Your payment was cancelled.";
    }
}

function executePayment($paymentId, $payerId) {
    $payment = Payment::get($paymentId, getApiContext());
    $paymentExecution = new PaymentExecution();
    $paymentExecution->setPayerId($payerId);
    $payment = $payment->execute($paymentExecution, getApiContext());
    return $payment;
}

list($order_info, $products) = getInfoOrderAdmin(5019);

if ($messageType === "success") {
    $smarty->assign('products', $products);
    $smarty->assign('order_info', $order_info);
    $smarty->display('checkout/order_success.tpl');
}
else{
    $smarty->assign('messageType', $messageType);
    $smarty->assign('message', $message);
    $smarty->display('checkout/order_failure.tpl');
}