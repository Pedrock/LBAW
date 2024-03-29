<?php
  ob_start("sanitize_output");
  $load_start = microtime(true);
  define('SECRET_KEY','MqTrC7HetY5YWvmdVAtQ2h4akgqsfNN38BwGg11MPiaRQelTIBCkSqorwS8FG9mI');
  session_set_cookie_params(3600, '/~lbaw1564/');
  session_start();

  error_reporting(E_ERROR | E_WARNING); // E_NOTICE by default

  $LINK = "https://gnomo.fe.up.pt";
  $BASE_DIR = '/opt/lbaw/lbaw1564/public_html/final/';
  $BASE_URL = '/~lbaw1564/final/';

  $conn = new PDO('pgsql:host=dbm;dbname=lbaw1564', 'lbaw1564', 'UA9GDW2I');
  $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $conn->exec('SET SCHEMA \'scrape\'');

  include_once($BASE_DIR . 'lib/smarty/Smarty.class.php');
  
  global $smarty;
  $smarty = new Smarty;
  $smarty->template_dir = $BASE_DIR . 'templates/';
  $smarty->compile_dir = $BASE_DIR . 'templates_c/';
  $smarty->assign('BASE_URL', $BASE_URL);
  $smarty->assign('load_start', $load_start);  
  
  set_error_handler("print_error_page", E_ERROR);
  set_exception_handler("print_error_page");

  if (empty($_SESSION["user"]))
  {
    include_once($BASE_DIR .'database/users.php');  
    rememberMe();
  }

  function rememberMe() {
    $cookie = isset($_COOKIE['rememberme']) ? $_COOKIE['rememberme'] : '';
    if ($cookie) {
      list ($user, $token, $mac) = explode(':', $cookie);
      if (!timingSafeCompare(hash_hmac('sha256', $user . ':' . $token, SECRET_KEY), $mac)) {
        return false;
      }
      $row = isValidLoginToken($user, $token);
      if ($row !== false) {
        $info = getUserInfo($user);
        if ($info !== false)
        {
          $_SESSION['user'] = $user;
          $_SESSION['username'] = $info['username'];
          $_SESSION['admin'] = $info['isadmin'];
        }
        return true;
      }
    }
    return false;
  }

/**
 * A timing safe equals comparison
 *
 * To prevent leaking length information, it is important
 * that user input is always used as the second parameter.
 *
 * @param string $safe The internal (safe) value to be checked
 * @param string $user The user submitted (unsafe) value
 *
 * @return boolean True if the two strings are identical.
 */
function timingSafeCompare($safe, $user) {
    if (function_exists('hash_equals')) {
        return hash_equals($safe, $user); // PHP 5.6
    }
    // Prevent issues if string length is 0
    $safe .= chr(0);
    $user .= chr(0);

    // mbstring.func_overload can make strlen() return invalid numbers
    // when operating on raw binary strings; force an 8bit charset here:
    if (function_exists('mb_strlen')) {
        $safeLen = mb_strlen($safe, '8bit');
        $userLen = mb_strlen($user, '8bit');
    } else {
        $safeLen = strlen($safe);
        $userLen = strlen($user);
    }

    // Set the result to the difference between the lengths
    $result = $safeLen - $userLen;

    // Note that we ALWAYS iterate over the user-supplied length
    // This is to prevent leaking length information
    for ($i = 0; $i < $userLen; $i++) {
        // Using % here is a trick to prevent notices
        // It's safe, since if the lengths are different
        // $result is already non-0
        $result |= (ord($safe[$i % $safeLen]) ^ ord($user[$i]));
    }

    // They are only identical strings if $result is exactly 0...
    return $result === 0;
}

function sanitize_output($buffer) {

    $search = array(
        '/\>[^\S ]+/s',  // strip whitespaces after tags, except space
        '/[^\S ]+\</s',  // strip whitespaces before tags, except space
        '/(\s)+/s'       // shorten multiple whitespace sequences
    );

    $replace = array(
        '>',
        '<',
        '\\1'
    );

    $buffer = preg_replace($search, $replace, $buffer);

    return $buffer;
}

function print_error_page()
{
  global $smarty;
  $smarty->display('error.tpl');
  die();
}

?>
