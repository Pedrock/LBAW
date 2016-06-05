<?php
 include_once('../config/init.php');
 http_response_code(404);
 $smarty->display('main/404.tpl');
 ?>

