<?php
  include_once('../../config/init.php');

  include_once($BASE_DIR .'lib/user_check.php'); 
  include_once($BASE_DIR .'database/users.php');

  $favorites = getUserFavorites($_SESSION['user']);

  $smarty->assign('favorites', $favorites);

  $smarty->display('user/favorites.tpl');
?>