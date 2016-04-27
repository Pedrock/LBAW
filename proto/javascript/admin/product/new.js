$(document).ready(function() {
	$("#files_btn").on('click', function(event) {
		$("#files").click();
	});

	$("#files").on('change', function(event) {
		var files = event.target.files;
		var files_len = event.target.files.length;

		var total_size = 0;

		var fd = new FormData();

		for(var i = 0; i < files_len; i++) {
			total_size += files[i].size;
			fd.append('file[' + i + ']', files[i]);

			var reader = new FileReader();

			(function (ii) {
				reader.onload = function (e) {
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
				url: "../../api/admin/product_photos.php",
				type: "POST",
				data: fd,
				contentType: false,
				cache: false,
				processData: false,
				success: function(html) {
					console.log('success: ' + html);
				},
				xhr: function () {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function (e) {
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
	});
});
