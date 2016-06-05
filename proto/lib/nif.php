<?php
function validNIF($nif) {
    if (!is_numeric($nif) || strlen($nif)!=9)
        return false;
    $nifSplit=str_split($nif);
    $checkDigit=0;
    for($i=0; $i<8; $i++) {
        $checkDigit+=$nifSplit[$i]*(10-$i-1);
    }
    $checkDigit=11-($checkDigit % 11);
    if($checkDigit>=10)
        $checkDigit=0;
    return ($checkDigit==$nifSplit[8]);
}