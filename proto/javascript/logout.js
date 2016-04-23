$('#logout').click(function(e) {
	e.preventDefault();
	$.ajax({
		type: "POST",
		url: "../api/users/logout.php",
		complete: function()
		{
			location.reload();
		}
	});
});