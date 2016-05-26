<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'lib/user_check.php'); 
  include_once($BASE_DIR .'database/users.php');

  $_SESSION['user'] = 3;

  $smarty->assign('favorites', getUserFavorites($_SESSION['user']));

  $smarty->display('user/favorites.tpl');
?>