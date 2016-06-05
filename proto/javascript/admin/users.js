$('input#show_admin').on('change', function() {
	if ($('input#show_admin').prop('checked'))
		window.location = "users.php?adminOnly";
	else
		window.location = "users.php";
});

$('#accordion-container').on('click', '.btn-user', function changeAdmin() {
	var button = $(this);
	button.blur();
	var user_id = button.closest('.user-row').attr('data-id');
	var add = button.hasClass('btn-danger');
	var name = button.closest('.user-row').children('.username').text();

	$.ajax({
		dataType: "json",
		url: "../../api/admin/users/changeAdmin.php",
		type: "POST",
		data: {user: user_id, setAdmin: add},
		success: function(e) {
			var text;
			if(e.success){
				if(add){
					text = "User " + name + " is now an admin";
					button.removeClass('btn-danger').addClass('btn-success');
				}
				else {
					text = "User " + name + " is no longer an admin";
					button.removeClass('btn-success').addClass('btn-danger');
				}
			} else{
				if (add)
					text = "User " + name + " was already an admin";
				else
					text = "User " + name + " already wasn't an admin";
			}
			$("#ok .modal-body").html(text);
			$("#ok").modal('toggle');
		},
		error: function(e) {
			if(e.responseText)
				$("#error .modal-body").html(JSON.parse(e.responseText).error);
			else
				$("#error .modal-body").html("Connection error!");
			$("#error").modal('toggle');
		}
	});
});

$('#ok, #error').on('shown.bs.modal', function () {
	$(this).find('button').focus();
});