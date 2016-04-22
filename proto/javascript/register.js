$('#register-button').click(function() {
	var username = $('input[name="username"]').val();
	var nif = $('input[name="nif"]').val();
	var email = $('input[name="email"]').val();
	var password = $('input[name="password"]').val();
	var password2 = $('input[name="password2"]').val();

	if (password != password2)
	{
		alert("Passwords don't match");
		return;
	}

	$.ajax({
		type: "POST",
		url: "../api/users/register.php",
		data: {username:username,nif:nif,email:email,password:password},
		complete: complete,
		dataType: 'json'
	});
})

function complete(xhr)
{
	if (Math.floor(xhr.status/100) == 2)
	{
		window.location.href = "index.php";
	}
	else if(xhr.responseJSON)
	{
		alert(xhr.responseJSON.error);
	}
	else
	{
		alert("Server error");
	}
}