<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/paypal.php');
include_once($BASE_DIR .'database/cart.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/products.php');

use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;

if(isset($_GET['success'])) {

    if($_GET['success'] == 'true' && isset($_GET['PayerID']) && isset($_GET['paymentId'])) {
        $orderId = $_GET['orderId'];
        if (isset($_SESSION['user']) && orderAlreadyPaid($_SESSION['user'], $orderId)) {
            $messageType = "success";
        }
        else {
            try {
                $result = prepareOrderPayment($orderId);
                if ($result === false) throw new Exception('Invalid Order',1);
                $payment = executePayment($_GET['paymentId'], $_GET['PayerID']);
                finishOrderPayment();
                $messageType = "success";
                $message = "Your payment was successful. Your order id is $orderId.";
                clearCart($_SESSION['user']);
            } catch (\PayPal\Exception\PPConnectionException $ex) {
                cancelOrderPayment();
                $message = parseApiError($ex->getData());
                $message = "An error occurred while completing your purchase.
                            <br>Please contact the administrator.
                            <br>Error code: ".$ex->getCode();
                $messageType = "error";
                var_error_log($ex);
            } catch (Exception $ex) {
                cancelOrderPayment();
                if ($ex->getCode() == 23514)
                {
                    $message = "One of the products you tried to buy does not have enough stock.<br>Please check your cart and try again.";
                }
                else
                    $message = "An error occurred while completing your purchase.
                            <br>Please contact the administrator.
                            <br>Error code: ".$ex->getCode();
                var_error_log($ex);
                $messageType = "error";
            }
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

if ($messageType === "success") {
    list($order_info, $products) = getInfoOrderAdmin($orderId);
    $smarty->assign('products', $products);
    $smarty->assign('order_info', $order_info);
    $smarty->display('checkout/order_success.tpl');
}
else{
    $smarty->assign('messageType', $messageType);
    $smarty->assign('message', $message);
    $smarty->display('checkout/order_failure.tpl');
}

function var_error_log( $object=null ){
    ob_start();                    // start buffer capture
    var_dump( $object );           // dump the values
    $contents = ob_get_contents(); // put the buffer into a variable
    ob_end_clean();                // end capture
    error_log( $contents );        // log contents of the result of var_dump( $object )
}