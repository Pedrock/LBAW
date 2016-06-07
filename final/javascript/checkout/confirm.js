$('#btn-confirm').click(function () {
    $(this).addClass('disabled');
    $('#spinner').removeClass('hidden');
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
        return;
    }
    else if(xhr.responseJSON)
    {
        $('#error .modal-body').text(xhr.responseJSON.error);
        $('#error').modal('show');
    }
    else
    {
        $('#error .modal-body').text('An error occurred. Please try again.');
        $('#error').modal('show');
    }
    $('#spinner').addClass('hidden');
    $('#btn-confirm').removeClass('disabled');
}