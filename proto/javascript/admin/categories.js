$(document).ready(function() {
	$(".href_add").on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		category_id = $(this).children('.category_id').html();
		$('#add_name').val("");
		$('#add').modal('toggle');
		console.log('add on ' + category_id);
	});

	$(".href_edit").on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		category_id = $(this).children('.category_id').html();
		category_name = $(this).children('.category_name').text();
		category_parent = $(this).children('.category_parent').html();
		if (category_parent == "") category_parent = 0;
		console.log('edit ' + category_id + " " + category_name + " " + category_parent);
		$('.modal .category_name').text(category_name);
		$('#edit_name').val(category_name);
		$('#edit_parent option').filter(":selected").removeAttr('selected');
		$('#edit_parent option[value='+category_parent+']').attr('selected','selected');
		$('#edit').modal('toggle');
	});

	$(".href_del").on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		category_id = $(this).children('.category_id').html();
		category_name = $(this).children('.category_name').text();
		console.log('delete ' + category_id);
		$('.modal .category_name').text(category_name);
		$('#del').modal('toggle');
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

		var cat = $('#cat_' + category_id);
		
		var new_num_child = cat.children('.categ_name').children('.categ_num_child');
		var num_updated = 1;

		if(typeof new_num_child.html() !== 'undefined')
			num_updated = parseInt(new_num_child.html().replace(' subcategories', ''));

		if(isNaN(num_updated))
			num_updated = 1;

		if (category_id == 0) 
			var post_data = {'name':name};
		else 
			var post_data = {'name':name,'parent':category_id};

		$.ajax({
			url: "../../api/admin/category/new.php",
			type: "POST",
			data: post_data,
			success: function(html) {
				console.log('success' + html);
				// FIXME todo
				location.reload();
				updateNum(cat, num_updated);
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
		if (new_parent == 0) 
			var post_data = {'id':category_id,'name':name};
		else 
			var post_data = {'id':category_id,'name':name,'parent':new_parent};

		$.ajax({
			url: "../../api/admin/category/edit.php",
			type: "POST",
			data: post_data,
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

	function updateNum(cat, num) {
		var par = $('#cat_' + cat.parent().attr('id'));

		var num_child = par.children('.categ_name').children('.categ_num_child');

		if(typeof num_child.html() !== 'undefined') {
			var new_num = parseInt(num_child.html().replace(' subcategories', '')) + num;

			if(new_num == 0) {
				num_child.html('');
				par.children('.icon').slideUp();
			}
			else
				num_child.html(new_num + " subcategories");

			updateNum(par, num);
		}
	}

	$("#btn_delete").on('click', function(event) {
		var cat = $('#cat_' + category_id);
		
		var deleting_num_child = cat.children('.categ_name').children('.categ_num_child');
		var num_deleting = 1;

		if(typeof deleting_num_child.html() !== 'undefined')
			num_deleting = parseInt(deleting_num_child.html().replace(' subcategories', ''));

		if(isNaN(num_deleting))
			num_deleting = 1;

		$.ajax({
			url: "../../api/admin/category/delete.php",
			type: "POST",
			data: {id: category_id},
			success: function(html) {
				console.log('success');
				updateNum(cat, -num_deleting);
				$('#cat_' + category_id).slideUp();
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				console.log(xhr);

				//$(".status_message").html('Failed to rename');
			}
		});
	});
});
