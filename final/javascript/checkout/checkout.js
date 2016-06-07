sameChecked();

$('.zipcode:not([value=""])').filter(function(){ return this.value; }).each(updateCity);

$("#same").change(sameChecked);

function sameChecked()
{
    if ($("#same")[0].checked) {
        $("#billing_box").slideUp();
        $("#same_as_shipping").slideDown();
    } else {
        $("#billing_box").slideDown();
        $("#same_as_shipping").slideUp();
    }
}

function payment() {
    var validates = true;
    $('#payment-form > input[name]').remove();
    if ($('#saved_shipping_addresses.active').length) {
        var address_id = $('#saved_shipping_addresses [name="ship_addr"]:checked').val();
        if (!address_id)
        {
            tooltip_error($('#saved_shipping_addresses'),'Address required');
            validates = false;
        }
        else
            $('#payment-form').append('<input type="hidden" name="ship_addr" value="'+address_id+'">');
    }
    else
    {
        $('#new_shipping_address > form input[name]').clone().attr('type','hidden').appendTo('#payment-form');
        if ($('[name="save_shipping"]').prop('checked'))
            $('#payment-form').append('<input type="hidden" name="same" value="on">');
    }

    if ($('#same').prop('checked'))
        $('#payment-form').append('<input type="hidden" name="same" value="on">');
    else {
        if ($('#saved_billing_addresses.active').length) {
            var address_id = $('#saved_billing_addresses [name="bill_addr"]:checked').val();
            if (!address_id)
            {
                tooltip_error($('#saved_billing_addresses'),'Address required');
                validates = false;
            }
            else $('#payment-form').append('<input type="hidden" name="bill_addr" value="'+address_id+'">');
        }
        else
        {
            $('#new_billing_address > form input[name]').clone().attr('type', 'hidden').appendTo('#payment-form');
            if ($('[name="save_billing"]').prop('checked'))
                $('#payment-form').append('<input type="hidden" name="same" value="on">');
        }
    }
    $('#payment-form').append('<input type="hidden" name="nif" value="'+$('#nif').val()+'">');

    if (!validNIF($('#nif').val())) {
        input_error($('#nif'),'Invalid NIF');
        validates = false;
    }

    return validates && validate_addresses();
}

$('#shipping_zip, #billing_zip, #nif').on('input', function() {
    input_valid($(this));
});

function validNIF(nif){
    if(!$.isNumeric(nif) || nif.length != 9)
        return false;
    var nifSplit = nif.split("");
    var checkDigit = 0;
    for(var i = 0; i < 8; i++){
        checkDigit += nifSplit[i]*(10-i-1);
    }
    checkDigit = 11-(checkDigit % 11);
    if(checkDigit >= 10)
        checkDigit=0;
    return (checkDigit == nifSplit[8]);
}

function validate_addresses()
{
    var validates = true;
    $('#new_shipping_address.active, #new_billing_address.active').each( function()
    {
        $(this).find('form input[required]').each( function() {
            if ($(this).val() == "")
            {
                validates = false;
                input_error($(this), "Input required");
            }
            else if ($(this).hasClass('zipcode') && $(this).attr('data-zip') != $(this).val())
            {
                validates = false;
                input_error($(this), "Invalid ZIP");
            }
            else if ($(this).hasClass('phone') && !$(this).val().match(/^(\+(?:[0-9] ?))?[0-9]{6,14}$/))
            {
                validates = false;
                input_error($(this), "Invalid phone number");
            }
            else
                input_valid($(this));
        });
    });
    return validates;
}

$('form input[required]').on('input', function () {
    input_valid($(this));
});

$('#payment_methods input').on('change' ,function () {
    $('#payment_methods *').tooltip('destroy');
});

$('#shipping_address a[data-toggle="tab"]').on('click', function () {
    $('#shipping_address *').tooltip('destroy');
});

$('#shipping_zip, #billing_zip').on('change focusout', updateCity);

function updateCity() {
    var input = $(this);
    var zip_code = input.val();
    var codes = zip_code.match(/^([0-9]{4})\-([0-9]{3})$/);
    if (codes && codes.length == 3) {
        $.ajax({
            url: "../../api/city.php",
            method: "GET",
            data: {zip1: codes[1], zip2: codes[2]},
            dataType: "json"
        }).done(function (data) {
            if (data) {
                input.closest('div').find('.city').val(data['city']);
                input.attr('data-zip', zip_code);
                input_valid(input);
            }
            else {
                input_error(input, 'Unknown zip code');
                input.closest('div').find('.city').val('');
            }
        }).fail(function () {
            input_error(input, 'Unknown zip code');
        });
    }
    else {
        input.closest('div').find('.city').val('');
        input_error(input, 'Invalid zip code');
    }
}

function input_error(element, error)
{
    tooltip_error(element, error);
    element.parent().addClass("has-error");
}

function tooltip_error(element, error)
{
    element.attr('title',error).tooltip({'trigger': 'hover focus'}).tooltip('fixTitle').tooltip('enable');
    setTimeout(function() {element.tooltip('show');}, 100);
}

function input_valid(element)
{
    element.tooltip('destroy');
    element.parent().removeClass("has-feedback has-error");
}