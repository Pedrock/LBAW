$(document).ready(function() {
	function changeAdmin(add){
		var name = $("#user").val();
		$.ajax({
			dataType: "json",
			url: "../../../api/admin/user/changeAdmin.php",
			type: "POST",
			data: {user: name, setAdmin: add},
			success: function(e) {
				console.log(e);
				console.log('success');
				var text;
				if(e.success){
					if(add)
						text = "User " + name + " is now an admin";
					else text = "User " + name + " is no longer an admin";
				} else{
					if(add)
						text = "User " + name + " was already an admin";
					else text = "User " + name + " already wasn't an admin";
				}
				$("#ok .modal-body").html(text);
				$("#ok").modal('toggle');
			},
			error: function(e) {
				console.log('error');
				console.log(e.responseText);
				$("#error .modal-body").html(JSON.parse(e.responseText).error);
				$("#error").modal('toggle');
			}
		});
	}
	$("#main_form").submit(function(e){
		e.preventDefault();
	});
	$("#btn_add").click(function(e){
		changeAdmin(true);
	});
	$("#btn_remove").click(function(e){
		changeAdmin(false);
	});
});