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
		$(selector).addClass("error_feedback");
		$(selector).tooltip('enable').attr('title', error).tooltip('fixTitle').tooltip('show');
	}

	function input_valid(selector) {
		if(typeof selector === 'undefined') selector = this;
		$(selector).tooltip('disable');
		$(selector).removeClass("error_feedback");
	}

	$("#main_form").on('submit', function(event) {
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
				url: "../../../api/admin/product/new.php",
				type: "POST",
				data: new FormData(this),
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

	/*$("#files").on('change', function(event) {
		var files = event.target.files;
		var files_len = event.target.files.length;

		var total_size = 0;

		var fd = new FormData();

		$(".drop_zone").html("");

		for (var i = 0; i < files_len; i++) {
			total_size += files[i].size;
			fd.append('file[' + i + ']', files[i]);

			var reader = new FileReader();

			(function(ii) {
				reader.onload = function(e) {
					var elem = $("<div class=\"product_img\"></div>");
					$(".drop_zone").append(elem);
					elem.css('background-image', 'url("' + e.target.result + '")');
					//elem.css('opacity', '0.5');
					//elem.html(ii);
				}
			}(i));

			reader.readAsDataURL(files[i]);

			continue;

			$.ajax({
				url: "../../api/admin/product/add_photos.php",
				type: "POST",
				data: fd,
				contentType: false,
				cache: false,
				processData: false,
				success: function(html) {
					console.log('success: ' + html);
				},
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						if (e.lengthComputable) {
							//var perc = parseInt(100 * e.loaded / e.total);
							//$(".status_message").html('Uploading... ' + perc + '%');
						}
					};
					return xhr;
				},
				error: function(xhr, textStatus, errorThrown) {
					console.log('error' + textStatus + errorThrown);
				}
			});
		}
	});*/
});
