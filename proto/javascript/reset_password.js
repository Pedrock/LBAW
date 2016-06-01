$('#password').on('input', function() { input_valid(); });
$('#password2').on('input', function() { input_valid(); });

$('#form-signin').submit(function(e) {
	e.preventDefault();

	var password = $('input[name="password"]').val();
	var password2 = $('input[name="password2"]').val();

	if (password === "")
		input_error("#password", "Please enter a password");
	else if (password2 === "")
		input_error("#password2", "Please confirm your password");
	else if (password != password2) {
		input_error("#password", null);
		input_error("#password2", "Passwords don't match");
	}

	if ($(".error_feedback").size() !== 0) {
		return;
	} else {
		$.ajax({
			type: "POST",
			url: "../api/users/reset_password.php",
			data: {id:id, token:token, password:password},
			complete: complete,
			dataType: 'json'
		});
	}
});

$('#error .close').click(function(e) {
	e.preventDefault();
	e.stopPropagation();

	$('#error').slideUp();
});

function complete(xhr) {
	console.log(xhr.responseText);
	if (Math.floor(xhr.status / 100) == 2) {
		$("#form-signin").slideUp();
		$("#error").slideUp();
		$("#success").slideDown();
		$("#login_btn").show();
	} else {
		var error = xhr.responseJSON ? xhr.responseJSON.error : "Server error. Please try again.";
		show_error(error);
	}
}

function input_error(selector, error) {
	$(selector).addClass("error_feedback");
	if(error != null)
		$(selector).tooltip('enable').attr('title', error).tooltip('fixTitle').tooltip('show');
}

function input_valid(selector) {
	$(".error_feedback").tooltip('disable');
	$(".error_feedback").removeClass("error_feedback");
}

function show_error(msg) {
	$("#error .msg").html(msg);
	$("#error").slideDown();
}