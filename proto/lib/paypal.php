<?php
include_once($BASE_DIR .'lib/PayPal-PHP-SDK/autoload.php');

function getApiContext()
{
    return new \PayPal\Rest\ApiContext(
        new \PayPal\Auth\OAuthTokenCredential(
            'AanfEqgCDTKRIy87ZEUwvQusxqUeUNW_FqdmH4fbAsMN5-ZtwWZ0yvNvEtU0-lnHZlKaDju6RpfpKu4b',     // ClientID
            'EKL-v8wByQBT7vUdiTcaOwZQB_Pu978JVBhXL057KhwpAM7xO9gmRJK_S6JMhpy1RZ7f9s1zToZFGS48'      // ClientSecret
        )
    );
}

