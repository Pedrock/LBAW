$(document).ready(function() {
	var dummyremove = $("#dummy-remove");
	dummyremove.hide();
	dummyremove.removeAttr('id');
	var dummyadd = $("#dummy-add");
	dummyadd.hide();
	dummyadd.removeAttr('id');
	$('input#show_admin').on('change', function() {
    if ($('input#show_admin').prop('checked'))
        	window.location = "user.php?adminOnly";
    	else
        	window.location = "user.php";
	});
	function changeAdmin(name, add, button){
		console.log(name);
		$.ajax({
			dataType: "json",
			url: "../../../api/admin/user/changeAdmin.php",
			type: "POST",
			data: {user: name, setAdmin: add},
			success: function(e) {
				var text;
				var elem = null;
				if(e.success){
					if(add){
						elem = dummyremove.clone().show();
						$(button).replaceWith(elem[0].outerHTML);
						removeHandler($(".remove-admin"));
						text = "User " + name + " is now an admin";
					}
					else {
						elem = dummyadd.clone().show();
						$(button).replaceWith(elem[0].outerHTML);
						addHandler($(".add-admin"));
						text = "User " + name + " is no longer an admin";
					}
				} else{
					if(add)
						text = "User " + name + " was already an admin";
					else text = "User " + name + " already wasn't an admin";
				}
				$("#ok .modal-body").html(text);
				$("#ok").modal('toggle');
			},
			error: function(e) {
				$("#error .modal-body").html(JSON.parse(e.responseText).error);
				$("#error").modal('toggle');
			}
		});
	}
	$("#main_form").submit(function(e){
		e.preventDefault();
	});
	$("#btn_add").click(function(e){
		changeAdmin($("#user").val(), true);
	});
	$("#btn_remove").click(function(e){
		changeAdmin($("#user").val(), false);
	});

	
	function addHandler(elem){
		elem.click(function(e){
			changeAdmin($(this).parent().siblings(".username").html(), true, this);
		});
		return elem;
	}
	function removeHandler(elem){
		elem.click(function(e){
			changeAdmin($(this).parent().siblings(".username").html(), false, this);
		});
		return elem;
	}
	removeHandler($(".remove-admin"));
	addHandler($(".add-admin"));
});