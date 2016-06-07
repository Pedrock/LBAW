<?php
  include_once('../config/init.php');
  session_start();
  $smarty->display('auth/register.tpl');
?>
