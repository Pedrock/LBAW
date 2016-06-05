function addAddress(){
    if (!validate_address($(this)))
        return;
    var form_elem = $(this);
    var form = form_elem.serializeArray();
    var input = $('#zip');
    var zip_code = input.val();
    var codes = zip_code.match(/^([0-9]{4})\-([0-9]{3})$/);
    var city = $('#city').val();
    form.push({name:'zip1', value:codes[1]},{name:'zip2', value:codes[2]});

    $.ajax({
        url: "../../api/users/add_address.php",
        method: "POST",
        data: form,
        dataType: "json"
    }).done(function(id) {
        $('.info-addresses > .nav-tabs a[href="#saved_addresses"]').tab('show');
        var clone = $('#dummy-address').clone();
        clone.removeAttr('id').removeClass('hidden').attr('data-id', id);
        var address = clone.find('.address');
        address.children(':nth-child(1)').text(form[0].value);
        address.children(':nth-child(2)').text(form[1].value);
        address.children(':nth-child(3)').text(form[2].value);
        address.find('.zip').text(form[3].value);
        address.find('.city').text(city);
        address.children(':nth-child(5)').text(form[4].value);
        $('#dummy-address').before(clone);
        form_elem.find('input').val('');
        updateNoAddresses();
    }).fail(function() {
        alert_error('Could not add the address. Please try again.');
    });
}

function updateNoAddresses()
{
    $('#no-addresses').toggleClass('hidden',$('.saved-address:not(.hidden)').length > 0);
}

function validate_address(element)
{
    var validates = true;
    element.find('input[name]:not([name="addr2"])').each( function() {
        if ($(this).attr('data-valid') === 'false')
            validates = false;
        else if ($(this).val() == "")
        {
            validates = false;
            input_error($(this), "Input required");
        }
        else if ($(this).attr('name') == 'phone' && !$(this).val().match(/^(\+(?:[0-9] ?))?[0-9]{6,14}$/))
        {
            input_error($(this), "Invalid phone number");
        }
        else
            input_valid($(this));

    });
    return validates;
}

function validate_zip(input)
{
    input.attr('data-valid','false');
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
            input.attr('data-valid','true');
        }).fail(function() {
            input_error(input, 'Unknown zip code');
        });
    }
    else {
        input.closest('div').find('.city').val('');
    }
}

$('#zip, #zip-edit').on('change focusout', function() {
    validate_zip($(this));
});

$('#new_address form').submit(addAddress);

$('form input').on('change input', function () {
    input_valid($(this));
    if ($(this).attr('name') == 'password1')
        input_valid($(this).closest('form').find('[name="password2"]'));
});

function input_error(element, error)
{
    tooltip_error(element, error);
    element.parent().addClass("has-feedback has-error");
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

$('#form-profile form').submit(function() {
    if ($(this).attr('disabled') === 'disabled') return;
    $(this).attr('disabled','disabled');
    $('.alert').slideUp(100);
    var nif = $('input[name="nif"]').val();
    var email = $('input[name="email"]').val();
    var password = $('input[name="password"]').val();
    var password1 = $('input[name="password1"]').val();
    var password2 = $('input[name="password2"]').val();

    if (nif == "" || email==""){
        if(nif == "")
            input_error($('input[name="nif"]'), "Input required");
        if(email == "")
            input_error($('input[name="email"]'), "Input required");
        return $(this).removeAttr('disabled');
    }
    if (password !== "" || password1 !== "" || password2 !== "")
    {
        if (password === "" || password1 === "" || password2 === ""){
            if(password === ""){
                input_error($('input[name="password"]'), "Input required");
                return $(this).removeAttr('disabled');
            }
            if(password1 === "" || password2 === ""){
                if(password1 === "")
                    input_error($('input[name="password1"]'), "Input required");
                if(password2 === "")
                    input_error($('input[name="password2"]'), "Input required");
                return $(this).removeAttr('disabled');
            }
        }
        if(password1 != password2){
            input_error($('input[name="password2"]'), "Passwords do not match");
            return $(this).removeAttr('disabled');
        }
    }

    $.ajax({
        type: "POST",
        url: "../../api/users/profile.php",
        data: {nif:nif,email:email,password:password,password1:password1},
        complete: profileUpdateComplete,
        dataType: 'json'
    })
});

function profileUpdateComplete(xhr)
{
    $('.alert').slideUp(100);
    $('#form-profile form').removeAttr('disabled');
    if (Math.floor(xhr.status/100) == 2)
    {
        $('<div class="alert alert-success alert-dismissible" role="alert">' +
            '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
            'Profile updated successfully!' +
            '</div>').insertBefore($("#form-profile .btn-save")).hide().slideDown();
    }
    else if(xhr.responseJSON)
    {
        if (xhr.responseJSON.errors)
        {
            for (input in xhr.responseJSON.errors)
            {
                input_error($("#"+input), xhr.responseJSON.errors[input])
            }
        }
        else if (xhr.responseJSON.error)
        {
            alert_error(xhr.responseJSON.error);
        }
    }
    else
    {
        alert_error("An error occurred. Please try again.");
    }
}

function deleteAddress(){
    var btn = $(this);
    var address_id = btn.closest('li').attr('data-id');

    $.ajax({
        url: "../../api/users/delete_address.php",
        method: "POST",
        data: {address_id:address_id}
    }).done(function() {
        btn.closest('li').fadeOut(400, function() {$(this).remove();updateNoAddresses();});

    }).fail(function() {
        alert_error('Could not delete the address. Please try again.');
    });
}

$('#saved_addresses').on('click', '.btn-trash', deleteAddress);

function alert_error(error)
{
    $('<div class="alert alert-danger alert-dismissible" role="alert">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        error +
        '</div>').insertBefore($("#form-profile .btn-save")).hide().slideDown();
}

function showEditModal(event) {
    var elem = $(this).closest('li');
    var address = elem.children('.address');
    var name = address.children(':nth-child(1)').text();
    var addr1 = address.children(':nth-child(2)').text();
    var addr2 = address.children(':nth-child(3)').text();
    var zipcode = address.find('.zip').text();
    var city = address.find('.city').text();
    var phonenumber = address.children(':last-child').text();

    input_valid($('#edit input'));

    $('#edit input[name="id"]').val(elem.attr('data-id'));
    $('#edit #name-edit').val(name);
    $('#edit #addr1-edit').val(addr1);
    $('#edit #addr2-edit').val(addr2);
    $('#edit #zip-edit').val(zipcode);
    $('#edit #city-edit').val(city);
    $('#edit #phone-edit').val(phonenumber);
    $('#edit').modal('show');
}

$('#saved_addresses').on('click', ".btn-edit-addr", showEditModal);

function editAddress(){
    if (!validate_address($(this)))
        return;

    var form = $(this).serializeArray();

    var zip_code = $('#edit #zip-edit').val();
    var codes = zip_code.match(/^([0-9]{4})\-([0-9]{3})$/);
    var city = $('#city-edit').val();

    form.push({name:'zip1', value:codes[1]},{name:'zip2', value:codes[2]});

    $.ajax({
        url: "../../api/users/edit_address.php",
        method: "POST",
        data: form
    }).done(function() {
        $('#edit').modal('hide');
        var id = $('#edit input[name="id"]').val();
        var address = $('.saved-address[data-id="'+id+'"]').children('.address');
        address.children(':nth-child(1)').text(form[0].value);
        address.children(':nth-child(2)').text(form[1].value);
        address.children(':nth-child(3)').text(form[2].value);
        address.find('.zip').text(form[3].value);
        address.find('.city').text(city);
        address.children(':last-child').text(form[4].value);

    }).fail(function() {
        alert_error('Could not edit the address. Please try again.');
    });
}

$('#edit form').submit(editAddress);