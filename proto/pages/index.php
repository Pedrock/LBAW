<?php
  include_once('../config/init.php');
  include_once($BASE_DIR .'database/products.php');
  $smarty->assign('categories', getMainCategories());
  $smarty->display('main/index.tpl');
?>