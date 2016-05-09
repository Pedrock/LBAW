$(document).ready(function() {
	$("#files_btn").on('click', function(event) {
		$("#files").click();
	});

	$('#editing').on('hidden.bs.modal', function(event) {
		if ($('#editing_error').is(':visible'))
			location.reload();
	});

	$('#confirmation').on('hidden.bs.modal', function(event) {
		window.location.href = "list.php";
	});

	function num_photos() {
		return $('.sortable').children().length;
	}

	if (num_photos() != 0) $('.no_photos').hide();

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
			move_photo(ui, start_pos, index);
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

	$("#files").on('change', function(event) {
		var files = event.target.files;

		var numAnswers = 0;

		if (files.length > 0) {
			$("#uploading_header").show();
			$("#error").hide();
			$("#uploading .progress").show();
			$(".done").hide();
			$("#total_num").html(files.length);
			$("#uploading").modal('show');

			upload_file(0, files, false);
		}
	});

	function update_message() {
		if (num_photos() != 0) $('.no_photos').hide();
		else $('.no_photos').show();
	}

	function upload_file(i, files, error) {
		$("#uploaded_num").html(i);

		//var ms = 2000;
		//ms += new Date().getTime();
		//while (new Date() < ms){}

		$('.progress .bar').css('width', (i / files.length) + '%');

		if (i >= files.length || error) {
			if (!error)
			//$("#uploading").modal('hide');
				$("#error").html("Photos added successfully.");
			else {
				$("#error").html("There was an error, some photos weren't added.");
			}

			$("#uploading .progress").hide();
			$("#uploading .done").show();
			$("#error").show();

			update_photo_orders();

			return;
		}

		var fd = new FormData();
		fd.append('file', files[i]);

		var order = num_photos() + i + 1;

		fd.append("action", "add");
		fd.append("id", id);
		fd.append("order", order);

		$.ajax({
			url: "../../../api/admin/product/photos.php",
			type: "POST",
			data: fd,
			contentType: false,
			cache: false,
			dataType: 'json',
			processData: false,
			success: function(html) {
				$("#uploaded_num").html(parseInt($("#uploaded_num").html()) + 1);
				var reader = new FileReader();

				(function(ii) {
					reader.onload = function(e) {
						var elem = $("<li class=\"product_img\" id=\"img_" + order + "\"></li>");
						var elem2 = $("<div class=\"del\">DEL<span class=\"hidden\">" + order + "</span></div>");
						$(elem).append(elem2);
						//$(elem2).append(elem2);
						$(elem2).on('click', photoDelete);
						$(".sortable").append(elem);
						elem.css('background-image', 'url("' + e.target.result + '")');
					}
				}(i));

				reader.readAsDataURL(files[i]);
				upload_file(i + 1, files, error);
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
				upload_file(i + 1, files, error);
				console.log('error' + textStatus + errorThrown + xhr.responseText);
			}
		});
	}

	function update_photo_orders() {
		$('.sortable').children().each(function(i) {
			$(this).attr("id", "img_" + (i + 1));
			var elem2 = $("<div class=\"del\">DEL<span class=\"hidden\">" + (i + 1) + "</span></div>");
			$(this).html("");
			$(this).append(elem2);
			//s$(elem2).append(elem2);
			$(elem2).on('click', photoDelete);
		});
	}

	function move_photo(ui, start_pos, index) {
		var fd = new FormData();

		fd.append("action", "edit");
		fd.append("id", id);
		fd.append("order", start_pos + 1);
		fd.append("new_order", index + 1);

		$('.sortable li div').css('opacity', '50%');

		$("#editing_header").show();
		$("#error").hide();
		$("#editing .progress").show();
		$(".done").hide();
		$("#total_num").html(files.length);
		$("#editing").modal('show');

		$.ajax({
			url: "../../../api/admin/product/photos.php",
			type: "POST",
			data: fd,
			contentType: false,
			cache: false,
			dataType: 'json',
			processData: false,
			success: function(html) {
				$("#editing").modal('hide');
				update_photo_orders();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error' + textStatus + errorThrown + xhr.responseText);
				$("#editing_error").html("There was an error.");

				$("#editing .done").show();
				$("#editing_error").show();
			}
		});
	}

	$('.del').on('click', photoDelete);

	var del_order;

	function photoDelete(event) {
		event.preventDefault(),
			event.stopPropagation();
		var order = $(this).children('.hidden').html();
		del_order = order;
		$("#del .confirmation").show();
		$("#del .deleting").hide();
		$("#del").modal('show');
	}

	$('#btn_delete').on('click', function() {
		var fd = new FormData();

		fd.append("action", "delete");
		fd.append("id", id);
		fd.append("order", del_order);

		$("#del .confirmation").slideUp();
		$("#del .deleting").html("Deleting...");
		$("#del .deleting").slideDown();

		$.ajax({
			url: "../../../api/admin/product/photos.php",
			type: "POST",
			data: fd,
			contentType: false,
			cache: false,
			dataType: 'json',
			processData: false,
			success: function(html) {
				$("#del").modal('hide');
				$("#img_" + del_order).remove();
				update_photo_orders();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error' + textStatus + errorThrown + xhr.responseText);
				$("#del .deleting").html("There was an error");
			}
		});
	});
});
