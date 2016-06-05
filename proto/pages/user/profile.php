<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'lib/user_check.php'); 
  include_once($BASE_DIR .'database/users.php');

  $user_id = $_SESSION['user'];

  $infoUser = getUserProfile($user_id);
  $email = $infoUser['email'];
  $nif = $infoUser['nif'];

  $addresses = getUserAddresses($user_id);
  if ($addresses[0]['id'] == null) $addresses = array();

  $smarty->assign('addresses',$addresses);
  $smarty->assign('nif',$nif);
  $smarty->assign('email',$email);
  $smarty->display('user/profile.tpl');
?>