<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'lib/nif.php');

    if (!$_POST['email'] || !$_POST['nif']){
        return_error("Both fields are required", 400);
        exit;
    }

    $user_id = $_SESSION['user'];

    $email = trim($_POST['email']);
    $nif = trim($_POST['nif']);
    $current_password = $_POST['password'];
    $new_password = $_POST['password1'];

    $errors = array();

    if (!filter_var($email, FILTER_VALIDATE_EMAIL))
    {
        $errors['email'] = "Invalid email";
    }

    $change_password = !(empty($current_password) && empty($new_password));

    if ($change_password && strlen($new_password) < 6)
        $errors['password1'] = "Passwords should have at least 6 characters";

    if (!validNIF($nif))
    {
        $errors['nif'] = "Invalid NIF";
    }

    if (!empty($errors))
        return_errors($errors);

    try {
        if ($change_password)
            $result = updateUserProfileAndPassword($user_id, $email, $nif, $current_password, $new_password);
        else
            $result = updateUserProfile($user_id, $email, $nif);
        if ($result === false)
        {
            $errors['password'] = "Incorrect Password";
            return_errors($errors);
        }
    } catch (PDOException $e) {
        return_error("Update failed");
    }

    function return_error($error, $code = 422)
    {
        http_response_code($code);
        echo json_encode(array('error' => $error));
        die();
    }

    function return_errors($error)
    {
        http_response_code(422);
        echo json_encode(array('errors' => $error));
        die();
    }
    
?>