$('#form-signin').submit(function(e) {
	e.preventDefault();
	var email = $('input[name="email"]').val();
	var password = $('input[name="password"]').val();

	$.ajax({
		type: "POST",
		url: "../api/users/login.php",
		data: {email:email,password:password},
		complete: complete,
		dataType: 'json'
	});
})

function complete(xhr)
{
	if (Math.floor(xhr.status/100) == 2)
	{
		window.location.href = redirect_dest;
	}
	else 
	{
		$("#sign-error").remove();
		var error = xhr.responseJSON ? xhr.responseJSON.error : "Server error. Please try again.";
		$('<div id="sign-error" class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
			+'<strong>Error!</strong> '
			+error
			+'</div>').hide().fadeIn("fast").insertBefore($("#account-wall"));
	}
}