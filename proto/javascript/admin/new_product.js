$(document).ready(function() {
	/*
	$("#files").on('change', function(event) {
		console.log('got files');
		var files = event.target.files;
		var files_len = event.target.files.length;

		var total_size = 0;

		for(var i = 0; i < files_len; i++)
			total_size += files[i].size;

		$('#images_form').submit();
	});

	$("#btn-upload-images").on('click', function(event) {
		console.log('asd');
		$('#images_form').submit();
	});

	$("#images_form").on('submit', (function(e) {
		e.preventDefault();
		console.log("uploading");
		$.ajax({
			url: "../../api/admin/product_photos.php",
			type: "POST",
			data: new FormData(this),
			contentType: false,
			cache: false,
			processData: false,
			success: function(html) {
				console.log('success');
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
				console.log('error');
			}
		});
	}));*/
});
