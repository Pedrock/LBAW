<?php
  include_once('../config/init.php');
  $smarty->assign('redirect_dest', isset($_GET['admin']) ? 'admin/index.php' : 'index.php');
  $smarty->display('auth/login.tpl');
?>
