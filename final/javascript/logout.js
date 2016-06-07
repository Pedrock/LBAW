$('#logout').click(function(e) {
	e.preventDefault();
	$.ajax({
		type: "POST",
		url: base_url+"api/users/logout.php",
		complete: function()
		{
			location.reload();
		}
	});
});