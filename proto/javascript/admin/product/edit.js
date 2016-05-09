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
		$("#error").modal('toggle');
			console.log(error);
		$("#error_description").html(error);
	}

	$('#name').on('input', function() { input_valid(this); });
	$('#price').on('input', function() { input_valid(this); });
	$('#stock').on('input', function() { input_valid(this); });
	$('#weight').on('input', function() { input_valid(this); });
	$('#description').on('input', function() { input_valid(this); });
	$('#categories').on('change', function() { input_valid(this); });

	function input_error(selector, error) {
		$(selector).addClass("error_feedback");
		$(selector).tooltip('enable').attr('title', error).tooltip('fixTitle').tooltip('show');
	}

	function input_valid(selector) {
		if(typeof selector === 'undefined') selector = this;
		$(selector).tooltip('disable');
		$(selector).removeClass("error_feedback");
	}

	function complete(xhr) {
		console.log(xhr.responseText);
		if (Math.floor(xhr.status / 100) == 2) {
			$("#edit").modal("toggle");
		} else if (xhr.responseJSON) {
			if (xhr.responseJSON.errors) {
				for (input in xhr.responseJSON.errors)
					input_error("#" + input, xhr.responseJSON.errors[input]);
			} else if (xhr.responseJSON.error) {
				alert_error(xhr.responseJSON.error);
			}
		} else {
			alert_error("An error occurred. Please try again.");
		}
	}

	$("#main_form").on("submit", function(event) {
				event.preventDefault();
		event.stopPropagation();

		var name = $('#name').val();
		var price = $('#price').val();
		var stock = $('#stock').val();
		var weight = $('#weight').val();
		var description = $('#description').val();

		if (name === "")
			input_error("#name", "Please enter a product name");

		if (price === "")
			input_error("#price", "Please enter a price");

		if (stock === "")
			input_error("#stock", "Please enter the product stock");

		if (weight === "")
			input_error("#weight", "Please enter the product weight");

		if (description === "")
			input_error("#description", "Please enter a product description");

		if (!$("#categories option:selected").length) {
			input_error("#categories", "Please select at least one category");
		}

		if ($(".error_feedback").size() !== 0) {
			return;
		} else {
			$.ajax({
				url: "../../../api/admin/product/edit.php",
				type: "POST",
				data: new FormData(this),
				contentType: false,
				dataType: 'json',
				cache: false,
				processData: false,
				complete: complete
			});
		}
	});
});
