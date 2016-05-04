$(document).ready(function() {
	$("#files_btn").on('click', function(event) {
		$("#files").click();
	});

	$('#confirmation').on('hidden.bs.modal', function(event) {
		window.location.href = "photos.php";
	});

	var ul_sortable = $('.sortable');
	ul_sortable.sortable({
		revert: 100,
		placeholder: 'placeholder',
		start: function(event, ui) {
			var start_pos = ui.item.index();
			ui.item.data('start_pos', start_pos);
		},
		update: function(event, ui) {
			var start_pos = ui.item.data('start_pos');
			var index = ui.item.index();
			var fd = new FormData();

			fd.append("action", "edit");
			fd.append("id", id);
			fd.append("order", start_pos + 1);
			fd.append("new_order", index + 1);

			$.ajax({
				url: "../../../api/admin/product/photos.php",
				type: "POST",
				data: fd,
				contentType: false,
				cache: false,
				//dataType: 'json',
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
					console.log('error' + textStatus + errorThrown + xhr.responseText);
				}
			});
		}
	});
	ul_sortable.disableSelection();

	function alert_error(error) {
		$("#error").modal('toggle');
		console.log(error);
		$("#error_description").html(error);
	}

	function complete(xhr) {
		if (Math.floor(xhr.status / 100) == 2) {
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

	var num_photos = 1;

	$("#files").on('change', function(event) {
		var files = event.target.files;
		var files_len = event.target.files.length;

		var error = false;

		var numAnswers = 0;

		if (files_len > 0) {
			$("#uploading_header").show();
			$("#error").hide();
			$("#uploading .progress").show();
			$(".done").hide();
			$("#uploaded_num").html('0');
			$("#total_num").html(files_len);
			$("#uploading").modal('show');

			for (var i = 0; i < files_len; i++) {
				var fd = new FormData();
				fd.append('file', files[i]);

				var reader = new FileReader();

				(function(ii) {
					reader.onload = function(e) {
						console.log('add');
						var elem = $("<li class=\"product_img\"></li>");
						$(".sortable").append(elem);
						elem.css('background-image', 'url("' + e.target.result + '")');
						//elem.css('opacity', '0.5');
						//elem.html(ii);
					}
				}(i));

				reader.readAsDataURL(files[i]);

				fd.append("action", "add");
				fd.append("id", id);
				fd.append("order", num_photos + i);

				$.ajax({
					url: "../../../api/admin/product/photos.php",
					type: "POST",
					data: fd,
					contentType: false,
					cache: false,
					//dataType: 'json',
					processData: false,
					success: function(html) {
						$("#uploaded_num").html(parseInt($("#uploaded_num").html()) + 1);
						console.log('success: ' + html);
						numAnswers++;
						if (numAnswers == files_len) {
							if (!error)
								$("#uploading").modal('hide');
							else {
								$("#uploading .progress").hide();
								$("#uploading .done").show();
							}
						}
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
						error = true;
						numAnswers++;
						if (numAnswers == files_len) {
							$("#uploading .progress").hide();
							$("#uploading .done").show();
						}
						console.log('error' + textStatus + errorThrown + xhr.responseText);
					}
				});
			}
		}
	});
});
