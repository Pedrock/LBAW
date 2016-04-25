<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR . 'database/users.php');

	include_once($BASE_DIR . 'lib/admin_check.php');

	$smarty->display('admin/index.tpl');
?>