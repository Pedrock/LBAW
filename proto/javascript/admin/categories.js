$(document).ready(function() {

	function updateCounts() {
		$('#manage-categories .list-group-item').each(function () {
			var id = $(this).attr('data-id');
			var length = $('#' + id).children('a').length;
			if (length != 0)
				$(this).find('.categ_num_child').text(length + (length == 1 ? " subcategory" : " subcategories"));
			else
				$(this).find('.categ_num_child').text('');
		});
	}

	updateCounts();

	$('.modal').on('shown.bs.modal', function() {
  		$('.modal input[type=text]').focus();
		$('.modal #btn_delete').focus();
	});

	function href_add_on_click(event) {
		event.preventDefault();
		event.stopPropagation();
		var category_id = $(this).children('.category_id').html();
		$('#add_name').val("");
		$('#add').prop('data-id',category_id);
		$('#add').modal('show');
	};

	$(".href_add").on('click', href_add_on_click);

	function href_edit_on_click(event) {
		event.preventDefault();
		event.stopPropagation();
		var category_id = $(this).children('.category_id').html();
		var category_name = $(this).children('.category_name').text();
		var category_parent = $(this).children('.category_parent').html();
		if (category_parent == "") category_parent = 0;
		$('.modal .category_name').text(category_name);
		$('#edit_name').val(category_name);
		$('#edit_parent option[value='+category_parent+']').attr('selected','selected');
		$('#edit_parent select').val(category_parent);
		$('#edit').prop('data-id',category_id);
		$('#edit').prop('data-parent',category_parent);
		$('#edit').modal('show');
	}

	$(".href_edit").on('click', href_edit_on_click);

	function href_del_on_click(event) {
		event.preventDefault();
		event.stopPropagation();
		var category_id = $(this).children('.category_id').html();
		var category_name = $(this).children('.category_name').text();
		$('.modal .category_name').text(category_name);
		$('#del').prop('data-id',category_id);
		$('#del').modal('show');
	}

	$(".href_del").on('click', href_del_on_click);

	function add_name_on_input(e){
		$(this).css('border-color', '#ccc');
	}

	$('#add_name').on('input', add_name_on_input);

	function edit_name_on_input(e){
		$(this).css('border-color', '#ccc');
	}

	$('#edit_name').on('input',edit_name_on_input);

	function btn_add_on_click(event) {
		var name = $('#add_name').val();

		if (name == '') {
			$('#add_name').css('border-color', 'red');
			event.preventDefault();
			return false;
		}

		var category_id = $('#add').prop('data-id');

		if (category_id == 0)
			var post_data = {'name':name};
		else 
			var post_data = {'name':name,'parent':category_id};

		$.ajax({
			url: "../../api/admin/category/new.php",
			type: "POST",
			data: post_data,
			success: function(html) {
				console.log('success');
				var json = JSON.parse(html);
				insertCategory(category_id, json.html);
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				show_error('Failed to add');
			}
		});
	}

	function insertCategory(parent_id, html)
	{
		var appendCategory = function(parent_div, elem)
		{
			var last = true;
			var name = elem.children('a > .categ_name').text().toLowerCase();
			parent_div.children('a').each(function()
			{
				if ($(this).children('.categ_name').text().toLowerCase() > name) {
					$(this).before(elem);
					last = false;
					return false;
				}
			});
			if (last)
				parent_div.append(elem);
		};

		var elem = $(html);
		if (parent_id != 0) {
			var div_parent = $("#cat_"+parent_id);
			if($("#"+parent_id).length == 0)
			{
				var children_div = $("<div class=\"list-group collapse in\" id=\"" + parent_id + "\"></div>");
				children_div.attr("aria-expanded","true");
				var div_parent = $("#cat_"+parent_id);
				children_div.insertAfter(div_parent);
			}
			div_parent.find(".icon").removeClass("hidden");
			div_parent.removeClass("collapsed");
			var parent = $("#"+parent_id);
			appendCategory(parent,elem);

			if (parent.hasClass('in')) {
				elem.filter('a').slideUp(0).slideDown(400, function () {
					$(this).css('display', '');
				});
				elem.removeClass("collapsed");
				elem.attr("aria-expanded", "true");
			}
			else
				parent.collapse('show');

		} else{
			appendCategory($("#categories-list"),elem);
			elem.filter('a').slideUp(0).slideDown(400,function(){ $(this).css('display',''); });
		}

		elem.find(".href_add").on("click", href_add_on_click);
		elem.find(".href_edit").on("click", href_edit_on_click);
		elem.find(".href_del").on("click", href_del_on_click);
		elem.find("#add_name").on("input", add_name_on_input);
		elem.find("#edit_name").on("input",edit_name_on_input);
		elem.find("#btn_add").on("click", btn_add_on_click);
		elem.find("#btn_edit").on("click", btn_edit_on_click);
		elem.find("#btn_delete").on("click", btn_delete_on_click);
		updateCounts();

		elem.find('.category').add(elem.filter('.category')).each(function () {
			var category_id = $(this).attr('data-id');
			var category = $('[data-id="'+category_id+'"]');
			var prev = 0;
			$('.category').each(function() {
				var id = $(this).attr('data-id');
				if (id == category_id) return false;
				prev = id;
			});
			var level = category.parentsUntil('#manage-categories','.list-group').length;
			var str = "";
			for (var i = 0; i < level; i++) str += "&nbsp;"
			str += category.children('.categ_name').text();
			$('#edit_parent option[value="'+prev+'"]').after('<option value="'+category_id+'">'+str+'</option>');
		});

	}

	$("#btn_add").on('click', btn_add_on_click);

	function btn_edit_on_click(event) {
		var name = $('#edit_name').val();

		if(name == '') {
			$('#edit_name').css('border-color', 'red');
			event.preventDefault();
			return false;
		}

		var category_id = $('#edit').prop('data-id');

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
				if ($('#edit').prop('data-parent') == new_parent)
				{
					$('a[data-id="'+category_id+'"] > .categ_name').text(name);
				}
				else
				{
					$.ajax({
						url: "../../api/admin/category/info.php",
						type: "GET",
						data: {id: category_id},
						success: function(html) {
							console.log('success');
							removeCategory(category_id);
							insertCategory(new_parent, html);
						},
						error: function(xhr, textStatus, errorThrown) {
							console.log('error');
							console.log(xhr);
							show_error('Failed to delete');
						}
					});
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				show_error('Failed to edit');
			}
		});
	}

	$("#btn_edit").on('click', btn_edit_on_click);


	function btn_delete_on_click(event) {
		var category_id = $('#del').prop('data-id');
		$.ajax({
			url: "../../api/admin/category/delete.php",
			type: "POST",
			data: {id: category_id},
			success: function(html) {
				console.log('success');
				removeCategory(category_id);
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				console.log(xhr);
				show_error('Failed to delete');
			}
		});
	}
	$("#btn_delete").on('click', btn_delete_on_click);

	function removeCategory(category_id)
	{
		var category = $('#cat_' + category_id);
		var children_div = $('#'+ category_id);
		var parent_category_id = category.parent().prop('id');
		var parent_category = $("[data-id='"+parent_category_id+"'");

		children_div.find('.category').add(category).each(function () {
			var id_to_remove = $(this).attr('data-id');
			$('#edit_parent option[value='+id_to_remove+']').remove();
		});


		var fixClass = function()
		{
			var parent_children = $('#'+parent_category_id);
			if (parent_children.children().length == 0)
				parent_category.find(".icon").addClass("hidden");
		};

		if (children_div.length == 0)
			category.slideUp("normal", function()
			{ $(this).remove(); fixClass(); updateCounts(); });
		else children_div.slideUp("normal", function()
		{ $(this).remove(); category.slideUp("normal", function()
		{ $(this).remove(); fixClass(); updateCounts(); } );} );
	}
	
	function show_error(error) {
		$("#error_description").text(error);
		$('#error').modal('show');
	}
});
