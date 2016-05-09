$(document).ready(function() {
	$("#files_btn").on("click", function(event) {
		event.stopPropagation();
		event.preventDefault();
		$("#files").click();
	});

	$("#btn-edit-product").on("click", function(event) {
		event.stopPropagation();
		event.preventDefault();
		$("#main_form").submit();
	});

	$("#edit").on('hidden.bs.modal', function(event) {
		window.location.href = "list.php";
	});

	function alert_error(error) {
		console.log("alert: " + error)
	}

	function input_error(selector, error) {
		console.log("input: " + selector + " - " + error)
	}

	function complete(xhr) {
		console.log(xhr.responseText);
		if (Math.floor(xhr.status / 100) == 2) {
			//window.location.href = "list.php"; // TODO
			$("#edit").modal("toggle");
		} else if (xhr.responseJSON) {
			if (xhr.responseJSON.errors) {
				input_valid(".form-group");
				for (input in xhr.responseJSON.errors) {
					input_error("#" + input, xhr.responseJSON.errors[input])
				}
			} else if (xhr.responseJSON.error) {
				alert_error(xhr.responseJSON.error);
			}
		} else {
			alert_error("An error occurred. Please try again.");
		}
	}

	$("#main_form").on("submit", function(event) {
		event.preventDefault();
		$.ajax({
			url: "../../../api/admin/product/edit.php",
			type: "POST",
			data: new FormData(this),
			contentType: false,
			cache: false,
			processData: false,
			complete: complete
		});
	});
});
