$(document).ready(function() {
	$(".href_add").on('click', function(event) {
		event.preventDefault();
		category_id = $(this).children('.category_id').html();
		$('#add_name').val("");
		console.log('add on ' + category_id);
	});

	$(".href_edit").on('click', function(event) {
		event.preventDefault();
		category_id = $(this).children('.category_id').html();
		category_name = $(this).children('.category_name').html();
		category_parent = $(this).children('.category_parent').html();
		console.log('edit ' + category_id + " " + category_name + " " + category_parent);
		$('.category_name').html(category_name);
		$('#edit_name').val(category_name);
		$("#edit_parent select").val(category_parent);
	});

	$(".href_del").on('click', function(event) {
		event.preventDefault();
		category_id = $(this).children('.category_id').html();
		category_name = $(this).children('.category_name').html();
		console.log('delete ' + category_id);
		$('.category_name').html(category_name);
	});

	$('#add_name').on('input',function(e){
		$(this).css('border-color', '#ccc');
	});

	$('#edit_name').on('input',function(e){
		$(this).css('border-color', '#ccc');
	});

	$("#btn_add").on('click', function(event) {
		var name = $('#add_name').val();

		if(name == '') {
			$('#add_name').css('border-color', 'red');
			event.preventDefault();
			return false;
		}

		$.ajax({
			url: "../../api/admin/category/new.php",
			type: "POST",
			data: "name=" + encodeURI(name) + (category_id != 0 ? "&parent=" + category_id : ""),
			success: function(html) {
				console.log('success');
				location.reload();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				//$(".status_message").html('Failed to rename');
			}
		});
	});

	$("#btn_edit").on('click', function(event) {
		var name = $('#edit_name').val();

		if(name == '') {
			$('#edit_name').css('border-color', 'red');
			event.preventDefault();
			return false;
		}

		var new_parent = $("#edit_parent").val();

		console.log(new_parent);

		$.ajax({
			url: "../../api/admin/category/edit.php",
			type: "POST",
			data: "id=" + category_id + "&name=" + encodeURI(name) + (new_parent != 0 ? "&parent=" + new_parent : ""),
			success: function(html) {
				console.log('success');
				location.reload();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				//$(".status_message").html('Failed to rename');
			}
		});
	});

	$("#btn_delete").on('click', function(event) {
		$.ajax({
			url: "../../api/admin/category/delete.php",
			type: "POST",
			data: "id=" + encodeURI(category_id),
			success: function(html) {
				console.log('success');
				location.reload();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				//$(".status_message").html('Failed to rename');
			}
		});
	});
});
