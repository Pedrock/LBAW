$('#form-signin').submit(function(e) {
	e.preventDefault();
	var email = $('input[name="email"]').val();

	$.ajax({
		type: "POST",
		url: "../api/users/recover_password.php",
		data: {email:email},
		complete: complete,
		dataType: 'json'
	});
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
	} else {
		var error = xhr.responseJSON ? xhr.responseJSON.error : "Server error. Please try again.";
		$("#error .msg").html(error);
		$("#error").slideDown();
	}
}