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

	$("#files").on('change', function(event) {
		var files = event.target.files;

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

	function upload_file(i, files, error) {
		$("#uploaded_num").html(i);

		$('.progress .bar').css('width', (i / files.length) + '%');

		if (i >= files.length || error) {
			if (!error)
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
				console.log(html.success);
				var img_path = "../../../images/products/thumb_" + html.success;
				$("#uploaded_num").html(parseInt($("#uploaded_num").html()) + 1);
				var elem = $("<li class=\"product_img\" id=\"img_" + order + "\"></li>");
				var elem2 = $("<div class=\"del\">DEL<span class=\"hidden\">" + order + "</span></div>");
				$(elem).append(elem2);

				$(elem2).on('click', photoDelete);
				$(".sortable").append(elem);
				elem.css('background-image', 'url("' + img_path + '")');

				upload_file(i + 1, files, error);
			},
			xhr: function() {
				var xhr = $.ajaxSettings.xhr();
				xhr.upload.onprogress = function(e) {
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
		
		$('#spinner').show();

		$.ajax({
			url: "../../../api/admin/product/photos.php",
			type: "POST",
			data: fd,
			contentType: false,
			cache: false,
			dataType: 'json',
			processData: false,
			success: function() {
				$('#spinner').hide();
				$("#editing").modal('hide');
				update_photo_orders();
			},
			error: function(xhr, textStatus, errorThrown) {
				$('#spinner').hide();
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
			success: function() {
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
