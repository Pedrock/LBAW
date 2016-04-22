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