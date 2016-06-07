<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'lib/user_check.php');
include_once($BASE_DIR .'database/cart.php');

updateCartPrices($_SESSION['user']);
