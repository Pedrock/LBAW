$("#same").change(function (e) {
    if (this.checked) {
        $("#billing_box").slideUp();
        $("#same_as_shipping").slideDown();
    } else {
        $("#billing_box").slideDown();
        $("#same_as_shipping").slideUp();
    }
});

function payment() {
    $('#payment-form > input[name]').remove();
    if ($('#saved_shipping_addresses.active').length) {
        var address_id = $('#saved_shipping_addresses [name="ship_addr"]:checked').val();
        if (!address_id) return false;
        $('#payment-form').append('<input type="hidden" name="ship_addr" value="'+address_id+'">');
    }
    else
        $('#new_shipping_address > form input[name]').clone().attr('type','hidden').appendTo('#payment-form');

    var same_as_shipping = $('#same').prop('checked');
    if (same_as_shipping)
        $('#payment-form').append('<input type="hidden" name="same" value="'+same_as_shipping+'">');
    else {
        if ($('#saved_billing_addresses.active').length) {
            var address_id = $('#saved_billing_addresses [name="bill_addr"]:checked').val();
            if (!address_id) return false;
            $('#payment-form').append('<input type="hidden" name="bill_addr" value="'+address_id+'">');
        }
        else
            $('#new_billing_address > form input[name]').clone().attr('type','hidden').appendTo('#payment-form');
    }
    $('#payment-form').append('<input type="hidden" name="nif" value="'+$('#nif').val()+'">');
    if ($('#payment-form [name="payment_method"]:checked').length == 0)
        return false;
    return true;
}

$('#shipping_zip, #billing_zip').on('input', function() {
    input_valid($(this));
});

$('#shipping_zip, #billing_zip').on('change focusout', function() {
    var input = $(this);
    var zip_code = input.val();
    var codes = zip_code.match(/^([0-9]{4})\-([0-9]{3})$/);
    if (codes && codes.length == 3)
    {
        $.ajax({
            url: "../../api/city.php",
            method: "GET",
            data: { zip1 : codes[1], zip2 : codes[2] },
            dataType: "json"
        }).done(function(data) {
            input.closest('div').find('.city').val(data['city']);
        }).fail(function() {
            input_error(input, 'Unknown zip code');
        });
    }
    else {
        input.closest('div').find('.city').val('');
        input_error(input, 'Invalid zip code');
    }
});

function input_error(element, error)
{
    element.attr('title',error).tooltip({'trigger': 'hover focus'}).tooltip('fixTitle').tooltip('enable');
    element.parent().addClass("has-feedback has-error");
    setTimeout(function() {element.tooltip('show');}, 100);
}

function input_valid(element)
{
    element.tooltip('destroy');
    element.parent().removeClass("has-feedback has-error");
}