$('#form-signin').submit(function(e) {
	e.preventDefault();
	var username = $('input[name="username"]').val();
	var nif = $('input[name="nif"]').val();
	var email = $('input[name="email"]').val();
	var password = $('input[name="password"]').val();
	var password2 = $('input[name="password2"]').val();

	if (username === "")
		input_error("#username","Please enter a username");

	if (nif === "")
		input_error("#nif","Please enter a NIF");

	if (email === "")
		input_error("#email","Please enter an email");

	if (password === "")
		input_error("#password","Please enter a password");
	else if (password2 === "")
		input_error("#password2","Please confirm your password");
	else if (password != password2)
		input_error("#password2","Passwords don't match");

	if ($(".glyphicon-remove").size() === 0)
		$.ajax({
			type: "POST",
			url: "../api/users/register.php",
			data: {username:username,nif:nif,email:email,password:password},
			complete: complete,
			dataType: 'json'
		});
	else $(".form-group input").tooltip('show');
})
function complete(xhr)
{
	if (Math.floor(xhr.status/100) == 2)
	{
		window.location.href = "index.php";
	}
	else if(xhr.responseJSON)
	{
		if (xhr.responseJSON.errors)
		{
			input_valid(".form-group");
			for (input in xhr.responseJSON.errors)
			{
				input_error("#"+input, xhr.responseJSON.errors[input])
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

$( "#form-signin input" ).on('input',function() {
	$(this).tooltip('disable').parent().removeClass().addClass("has-feedback").find(".glyphicon").removeClass("glyphicon-ok glyphicon-warning-sign glyphicon-remove");
});

function alert_error(error)
{
	$("#sign-error").remove();
	$('<div id="sign-error" class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
		+'<strong>Error!</strong> '
		+error
		+'</div>').hide().fadeIn("fast").insertBefore($("#account-wall"));
}

function input_error(selector, error)
{
	$(selector+" .glyphicon").removeClass("glyphicon-ok glyphicon-warning-sign glyphicon-remove").addClass("glyphicon-remove");
	$(selector+" .has-feedback").removeClass().addClass("has-feedback has-error");
	$(selector+" input").tooltip('enable').attr('title',error).tooltip('fixTitle').tooltip('show');
}

function input_valid(selector)
{
	$(selector+" input").tooltip('disable');
	$(selector+" .glyphicon").removeClass("glyphicon-ok glyphicon-warning-sign glyphicon-remove").addClass("glyphicon-ok");
	$(selector+" .has-feedback").removeClass().addClass("has-feedback has-success");
}