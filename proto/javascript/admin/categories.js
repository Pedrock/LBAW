$(document).ready(function() {
	$('.modal').on('shown.bs.modal', function() {
  		$('.modal input[type=text]').focus();
	});

	var href_add_on_click = function(event) {
		event.preventDefault();
		event.stopPropagation();
		category_id = $(this).children('.category_id').html();
		$('#add_name').val("");
		$('#add').modal('toggle');
		console.log('add on ' + category_id);
	}

	$(".href_add").on('click', href_add_on_click);

	function href_edit_on_click(event) {
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
	}

	$(".href_edit").on('click', href_edit_on_click);

	function href_del_on_click(event) {
		event.preventDefault();
		event.stopPropagation();
		category_id = $(this).children('.category_id').html();
		category_name = $(this).children('.category_name').text();
		console.log('delete ' + category_id);
		$('.modal .category_name').text(category_name);
		$('#del').modal('toggle');
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
				console.log('success ' + html);
				// FIXME todo
				//location.reload();
				//updateNum(cat, num_updated);
				var id = JSON.parse(html).id;
				$.ajax({
					url: "../../api/admin/category/info.php",
					type: "POST",
					data: {'id' : id},
					success: function(html) {
						console.log('success ' + html);
						var elem =  $(html);
						if(category_id != 0){
							if($("#"+category_id).length == 0){
								console.log("added div");
								var children_div = $("<div class=\"list-group collapse in\" id=\"" + category_id + "\"></div>");
								children_div.attr("aria-expanded","true");
								var div_parent = $("#cat_"+category_id);
								children_div.insertAfter(div_parent);
								div_parent.find(".icon").removeClass("hidden");
								div_parent.removeClass("collapsed");
								div_parent.find(".categ_num_child").html("1 subcategories");
							} 
							$("#"+category_id).append(elem);
							$("#"+category_id).addClass("in");
							elem.slideUp(0).slideDown(400);
							elem.removeClass("collapsed");
							elem.attr("aria-expanded", "true");
						} else{
							$("#categories-list").append(elem);
							elem.slideUp(0).slideDown(400);
						}	

						elem.find(".href_add").on("click", href_add_on_click);
						elem.find(".href_edit").on("click", href_edit_on_click);
						elem.find(".href_del").on("click", href_del_on_click);
						elem.find("#add_name").on("input", add_name_on_input);
						elem.find("#edit_name").on("input",edit_name_on_input);
						elem.find("#btn_add").on("click", btn_add_on_click);
						elem.find("#btn_edit").on("click", btn_edit_on_click);
						elem.find("#btn_delete").on("click", btn_delete_on_click);
						updateNum(cat, num_updated);
					},
					error: function(xhr, textStatus, errorThrown) {
						console.log('error');
					}
				});
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				//$(".status_message").html('Failed to rename');
			}
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
				//location.reload();
				if(new_parent != 0){
					
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				//$(".status_message").html('Failed to rename');
			}
		});
	}

	$("#btn_edit").on('click', btn_edit_on_click);

	function updateNum(cat, num) {
		var par = $('#cat_' + cat.parent().attr('id'));

		var num_child = par.children('.categ_name').children('.categ_num_child');

		if(typeof num_child.html() !== 'undefined') {
			var new_num = parseInt(num_child.html().replace(' subcategories', '')) + num;

			if(new_num == 0) {
				num_child.html('');
				par.children('.icon').slideUp();
			}
			else if(isNaN(new_num)){
				console.log("num: " + num);
				console.log("parse:" + num_child.html().replace(' subcategories', '')); 
				num_child.html("1 sub0categories");
			} else {
				num_child.html(new_num + " sub1categories");
			}

			updateNum(par, num);
		}
	}
	function btn_delete_on_click(event) {
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
				if($('#'+ category_id).length == 0)
					$('#cat_' + category_id).slideUp("normal", function() { $(this).remove(); });
				else $('#'+ category_id).slideUp("normal", function() { $(this).remove(); $('#cat_' + category_id).slideUp("normal", function() { $(this).remove(); } );} );
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log('error');
				console.log(xhr);
				//$(".status_message").html('Failed to rename');
			}
		});
	}
	$("#btn_delete").on('click', btn_delete_on_click);
});
/*
<a href="#315" class="list-group-item collapsed clearfix" data-toggle="collapse" id="cat_315" style="background-color: rgb(255,255,255);">
	<span class="icon hidden"></span>
	<span class="categ_name">
		zzzz
		<span class="categ_num_child"></span>
	</span>
	<span class="pull-right">
		<button class="href_add" data-toggle="modal" data-target="#add">
			<span class="hidden category_id">315</span>
			<span class="glyphicon glyphicon-plus"></span>
		</button>
		<button class="href_edit" data-toggle="modal" data-target="#edit">
			<span class="hidden category_id">315</span>
			<span class="hidden category_name">zzzz</span>
			<span class="hidden category_parent"></span>
			<span class="glyphicon glyphicon-pencil"></span>
		</button>
		<button class="href_del" data-toggle="modal" data-target="#del">
			<span class="hidden category_id">315</span>
			<span class="hidden category_name">zzzz</span>
			<span class="glyphicon glyphicon-trash"></span>
		</button>
	</span>
</a>
<a href="#316" class="list-group-item collapsed clearfix" data-toggle="collapse" id="cat_316" style="background-color: rgb(255,255,255);">
	<span class="icon hidden"></span>
	<span class="categ_name">
		zzzzzzzz
		<span class="categ_num_child"></span>
	</span>
	<span class="pull-right">
		<button class="href_add" data-toggle="modal" data-target="#add">
			<span class="hidden category_id">316</span>
			<span class="glyphicon glyphicon-plus"></span>
		</button>
		<button class="href_edit" data-toggle="modal" data-target="#edit">
			<span class="hidden category_id">316</span>
			<span class="hidden category_name">zzzzzzzz</span>
			<span class="hidden category_parent"></span>
			<span class="glyphicon glyphicon-pencil"></span>
		</button>
		<button class="href_del" data-toggle="modal" data-target="#del">
			<span class="hidden category_id">316</span>
			<span class="hidden category_name">zzzzzzzz</span>
			<span class="glyphicon glyphicon-trash"></span>
		</button>
	</span>
</a>*/