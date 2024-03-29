$(document).ready(function() {
	$("#files_btn").on('click', function(event) {
		$("#files").click();
	});

	$("#btn-new-product").on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		$("#main_form").submit();
	});

	var product_id = '';

	$('#confirmation').on('hidden.bs.modal', function(event) {
		if(product_id != '')
			window.location.href = "photos.php?id=" + product_id;
		else
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
		console.log('error: ' + error);
		$(selector).addClass("error_feedback");
		$(selector).tooltip('enable').attr('title', error).tooltip('fixTitle').tooltip('show');
	}

	function input_valid(selector) {
		if(typeof selector === 'undefined') selector = this;
		$(selector).tooltip('disable');
		$(selector).removeClass("error_feedback");
	}

    CKEDITOR.replace('description');

	$("#main_form").on('submit', function(event) {
		event.preventDefault();
		event.stopPropagation();

		var name = $('#name').val();
		var price = $('#price').val();
		var stock = $('#stock').val();
		var weight = $('#weight').val();
		var description = CKEDITOR.instances.description.document.getBody().getHtml();

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

		var fd = new FormData(this);
		fd.append('description', description);

		if ($(".error_feedback").size() !== 0) {
			return;
		} else {	
			$.ajax({
				url: "../../../api/admin/product/new.php",
				type: "POST",
				data: fd,
				contentType: false,
				cache: false,
				processData: false,
				dataType: 'json',
				complete: complete
			});
		}
	});

	function complete(xhr) {
		if (Math.floor(xhr.status / 100) == 2) {
			if (xhr.responseJSON.id)
				product_id = xhr.responseJSON.id;
			$("#confirmation").modal('toggle');
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
});
