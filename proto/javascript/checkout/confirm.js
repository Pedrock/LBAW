$('#btn-confirm').click(function () {
    $(this).addClass('disabled');
    $.ajax({
        url: "../../api/checkout/confirm.php",
        method: "POST",
        data: vars,
        dataType: "json",
        complete: confirmComplete
    });
});

function confirmComplete(xhr)
{

    if (xhr.status == 200 && xhr.responseJSON)
    {
        window.location.href = xhr.responseJSON;
    }
    else if(xhr.responseJSON)
    {
        alert(xhr.responseJSON);
    }
    else
    {
        alert("An error occurred. Please try again.");
    }
}